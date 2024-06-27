package org.example.main;

import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketConfig;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.SocketIOServer;
import lombok.extern.slf4j.Slf4j;
import lombok.val;
import org.example.Game;
import org.example.GameStatus;
import org.example.dto.*;
import org.example.entity.Player;
import org.example.events.in_progress.CloseEvent;
import org.example.events.in_progress.MoveEvent;
import org.example.events.in_progress.SpellCastEndEvent;
import org.example.events.in_progress.SpellCastStartEvent;
import org.example.events.preparation.NewPlayerEvent;
import org.example.events.preparation.StartGameEvent;

import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

@Slf4j
public class ChatLauncher {

    public static final int PORT = 9092;

    public static final int SEND_STATE_PERIOD = 50;
    public static final int LIVE_ZONE_SHRINK_PERIOD = 15_000;
    private static final int DEAD_ZONE_TICK_PERIOD = 1000;

    public static void main(String[] args) {

        final SocketIOServer server = createServer();

        Game game = new Game();

        server.addEventListener("newPlayer", PlayerDto.class,
                new NewPlayerEvent(game));
        server.addEventListener("startGame", StartGameDto.class,
                new StartGameEvent(game));
        server.addEventListener("move", MoveDto.class,
                new MoveEvent(game));
        server.addEventListener("spellCastStart", CastSpellDto.class,
                new SpellCastStartEvent(game));
        server.addEventListener("spellCastEnd", CastSpellDto.class,
                new SpellCastEndEvent(game));

        server.addEventListener("close", CloseDto.class, new CloseEvent(game));


        server.addDisconnectListener(client -> {
            log.info("Attempt to disconnect");
            val disconnectedPlayerId = (String) client.get("player_id");
            if (disconnectedPlayerId == null) {
                return;
            }
            log.warn("player {} disconnected", disconnectedPlayerId);
            val disconnectedPlayer = game.players
                    .stream()
                    .filter(p -> p.getId().equals(disconnectedPlayerId))
                    .findFirst();
            if (disconnectedPlayer.isPresent()) {
                game.updateDeathTimes(disconnectedPlayer.get());
                game.removePlayer(disconnectedPlayerId);
            }
        });

        ScheduledThreadPoolExecutor executor = new ScheduledThreadPoolExecutor(10);

        executor.scheduleAtFixedRate(() -> {
                    if (game.status.equals(GameStatus.IN_PROGRESS)) {
                        game.arena.shrinkLifeArea();
                    }
                },
                LIVE_ZONE_SHRINK_PERIOD,
                LIVE_ZONE_SHRINK_PERIOD,
                TimeUnit.MILLISECONDS);

        executor.scheduleAtFixedRate(() -> {
                    if (game.status.equals(GameStatus.IN_PROGRESS)) {
                        game.deadZoneTick();
                    }
                },
                DEAD_ZONE_TICK_PERIOD,
                DEAD_ZONE_TICK_PERIOD,
                TimeUnit.MILLISECONDS);

        executor.scheduleAtFixedRate(() -> {
            if (game.status.equals(GameStatus.IN_PROGRESS)) {
                for (var p : game.gameState.players) {
                    p.getDebuffs()
                            .removeIf(d -> {
                                if (d.getEndTimestamp() != null) {
                                    try {
                                        return ZonedDateTime.now().isAfter(d.getEndTimestamp());
                                    } catch (Exception e) {
                                        return false;
                                    }
                                }
                                return false;
                            });

                    p.getBuffs()
                            .removeIf(d -> {
                                if (d.getEndTimestamp() != null) {
                                    try {
                                        return ZonedDateTime.now()
                                                .isAfter(d.getEndTimestamp());
                                    } catch (Exception e) {
                                        return false;
                                    }
                                }
                                return false;
                            });
                }
            }

            if (game.status.equals(GameStatus.IN_PROGRESS) &&
                    game.countPlayersAlive() <= 1) {
                game.end();
                log.info("GAME OVER");
                log.info(game.deathTimes.toString());
            }

            Object dataToSend = null;
            switch (game.status) {
                case PREPARATION, IN_PROGRESS -> dataToSend = game.gameState;
                case OVER -> {
                    var m = new HashMap<>();
                    val winner = game.players
                            .stream()
                            .filter(Player::isAlive)
                            .findFirst()
                            .orElseThrow(() -> new RuntimeException("No winner"));
                    val w = new HashMap<>();
                    w.put("id", winner.getId());
                    w.put("name", winner.getName());

                    m.put("players", game.deathTimes);
                    m.put("status", GameStatus.OVER);
                    m.put("winner", w);

                    dataToSend = m;
                }
            }

            server.getBroadcastOperations().sendEvent("gameState", dataToSend);
        }, 0, SEND_STATE_PERIOD, TimeUnit.MILLISECONDS);

        log.info("SERVER START");
        server.start();

    }

    private static SocketIOServer createServer() {
        Configuration config = new Configuration();
        SocketConfig socketConfig = config.getSocketConfig();
        socketConfig.setReuseAddress(true);
        config.setHostname("localhost");
        config.setPort(PORT);
        log.info("Set localhost: {}", PORT);
        return new SocketIOServer(config);
    }

}
