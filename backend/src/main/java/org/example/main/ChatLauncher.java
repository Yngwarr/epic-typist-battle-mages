package org.example.main;

import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketConfig;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.SocketIOServer;
import lombok.extern.slf4j.Slf4j;
import org.example.Game;
import org.example.dto.CastSpellDto;
import org.example.dto.MoveDto;
import org.example.dto.PlayerDto;
import org.example.dto.StartGameDto;
import org.example.entity.GameState;
import org.example.events.in_progress.MoveEvent;
import org.example.events.in_progress.SpellCastEndEvent;
import org.example.events.in_progress.SpellCastStartEvent;
import org.example.events.preparation.NewPlayerEvent;
import org.example.events.preparation.StartGameEvent;

import java.time.ZonedDateTime;
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
        GameState gameState = game.getStatus();

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

        server.addDisconnectListener((SocketIOClient client) -> {
            log.warn("player {} disconnected", client.getSessionId());
            game.removePlayer(client.getSessionId());
        });

        ScheduledThreadPoolExecutor executor = new ScheduledThreadPoolExecutor(10);

        executor.scheduleAtFixedRate(game.arena::shrinkLifeArea,
                LIVE_ZONE_SHRINK_PERIOD,
                LIVE_ZONE_SHRINK_PERIOD,
                TimeUnit.MILLISECONDS);

        executor.scheduleAtFixedRate(game::deadZoneTick,
                DEAD_ZONE_TICK_PERIOD,
                DEAD_ZONE_TICK_PERIOD,
                TimeUnit.MILLISECONDS);

        executor.scheduleAtFixedRate(() -> {
            // every 50 ms send to all players event with new gamestate
            // check every debuff: if it is done - remove it
            for (var p : game.gameState.players) {
                p.getDebuffs()
                        .removeIf(d -> ZonedDateTime.now().isAfter(ZonedDateTime.parse(d.getEndTimestamp())));
            }

            server.getBroadcastOperations().sendEvent("gameState", gameState);
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
