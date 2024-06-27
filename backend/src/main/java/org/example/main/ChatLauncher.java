package org.example.main;

import com.corundumstudio.socketio.*;
import lombok.extern.slf4j.Slf4j;
import org.example.Game;
import org.example.dto.CastSpellDto;
import org.example.dto.MoveDto;
import org.example.dto.PlayerDto;
import org.example.entity.Direction;
import org.example.entity.GameState;
import org.example.entity.Player;
import org.example.entity.spell.SpellFabric;

import java.time.Instant;
import java.time.ZonedDateTime;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Slf4j
public class ChatLauncher {

    public static final int PORT = 9092;

    public static final int SEND_STATE_PERIOD = 50;
    public static final int LIVE_ZONE_SHRINK_PERIOD = 15_000;
    private static final int DEAD_ZONE_TICK_PERIOD = 1000;

    public static void main(String[] args) {

        final SocketIOServer server = createServer();

        Game game = new Game();
        GameState gameState = game.getState();

        server.addEventListener("newPlayer", PlayerDto.class,
                (client, data, ackRequest) -> {
                    if (data == null) {
                        return;
                    }
                    var name = data.getName();
                    log.info("New player with name {}", name);
                    Player newPlayer = game.addPlayer(name, client.getSessionId());
                    log.info("Added player {}", newPlayer);

                    ackRequest.sendAckData(newPlayer);

                    client.sendEvent("newPlayer", new AckCallback<>(String.class) {
                        @Override
                        public void onSuccess(String result) {
                            System.out.println("ack from client: " + client.getSessionId() + " data: " + result);
                        }
                    }, newPlayer);

                });

        server.addEventListener("move", MoveDto.class,
                (client, data, ackRequest) -> {
                    if (data != null) {
                        var playerId = data.getPlayerId();
                        log.info("receive move {} player {}", data.getDirection(), playerId);
                        var maybePlayer = game.getPlayerById(playerId);
                        if (maybePlayer != null && maybePlayer.isAlive()) {
                            game.movePlayer(maybePlayer, Direction.valueOf(data.getDirection().toUpperCase()));
                            log.info("moved player {}", playerId);
                        } else {
                            log.info("move: no such player {}", playerId);
                        }
                    }
                });

        server.addEventListener("spellCastStart", CastSpellDto.class,
                (client, data, ackRequest) -> {
                    if (data == null) {
                        return;
                    }
                    var from = game.getPlayerById(data.playerFromId);
                    if (from != null && !from.isAlive()) {
                        logDeadCaster(data);
                        return;
                    }
                    log.info("got spellCast start : {}", data);
                    var to = data.playerToId;
                    var maybePlayer = game.getPlayerById(to);
                    if (maybePlayer != null) {
                        game.spellsInProgress.add(data);
                    } else {
                        log.info("cast is not successful (playerToId is null). spell {}", data);
                    }
                });

        server.addEventListener("spellCastEnd", CastSpellDto.class,
                (client, data, ackRequest) -> {
                    if (data == null) {
                        log.info("cast end: no data");
                        return;
                    }
                    var from = game.getPlayerById(data.playerFromId);
                    if (from != null && !from.isAlive()) {
                        logDeadCaster(data);
                        return;
                    }

                    log.info("got spellCasted: {}", data);
                    var spellname = data.spellName;
                    var to = data.playerToId;
                    var maybePlayer = game.getPlayerById(to);
                    boolean ok = 1 == game.spellsInProgress.stream()
                            .filter(s -> s.getSpellCastId().equals(data.getSpellCastId())).count();
                    var spell = SpellFabric.getSpell(spellname);
                    if (maybePlayer != null && spell != null && ok) {
                        game.spellsInProgress.removeIf(s -> s.spellCastId.equals(data.getSpellCastId()));
                        spell.processSpell(from, maybePlayer);
                        log.info("deal damage to {}", maybePlayer);
                    } else {
                        log.info("cast is not successful, player {}, spell {}, spell found in spellsInProgress {}, spells in progress {}",
                                maybePlayer, spell, ok, game.spellsInProgress);
                    }
                });

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

    private static void logDeadCaster(CastSpellDto data) {
        log.info("cast is not successful (caster is dead). spell {}", data);
    }

}
