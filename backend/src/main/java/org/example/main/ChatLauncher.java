package org.example.main;

import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketIOServer;
import lombok.extern.slf4j.Slf4j;
import org.example.Game;
import org.example.dto.CastSpellDto;
import org.example.dto.MoveDto;
import org.example.entity.Direction;
import org.example.entity.GameState;
import org.example.entity.Player;
import org.example.entity.spell.SpellFabric;

import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

@Slf4j
public class ChatLauncher {

    public static final int SEND_STATE_PERIOD = 50;
    public static final int LIVE_ZONE_SHRINK_PERIOD = 15_000;

    public static void main(String[] args) throws InterruptedException {

        Configuration config = new Configuration();
        config.setHostname("localhost");
        config.setPort(9092);
        log.info("Set localhost:9092");
        Game game = new Game();
        Player somePlayer = new Player("hui-id", 100, "Slava", 1, 1);
        game.addPlayer(somePlayer);
        log.info("add player {}", somePlayer);
        GameState gameState = game.getState();

        final SocketIOServer server = new SocketIOServer(config);
        server.addEventListener("chatevent", MoveDto.class,
                (client, data, ackRequest) -> {
                    var playerId = data.getPlayerId();
                    log.info("receive move {} player {}", data.getDirection(), playerId);
                    var maybePlayer = game.getPlayerById(playerId);
                    if (maybePlayer != null) {
                        game.movePlayer(maybePlayer, Direction.valueOf(data.getDirection().toUpperCase()));
                        log.info("moved player {}", playerId);
                    } else {
                        log.info("move: no such player {}", playerId);

                    }
                });
        server.addEventListener("spellCasted", CastSpellDto.class,
                (client, data, ackRequest) -> {
                    // broadcast messages to all clients
                    log.info("got spellCasted: {}", data);
                    var spellname = data.spellName;
                    var to = data.playerToId;
                    var maybePlayer = game.getPlayerById(to);
                    var spell = SpellFabric.getSpell(spellname);
                    if (maybePlayer != null && spell != null) {
                        var from = game.getPlayerById(data.playerFromId);
                        spell.dealDamage(from, maybePlayer);
                        log.info("deal damage to {}", maybePlayer);
                    } else {
                        log.info("cast is not successful, player {}, spell {}", maybePlayer, spell);
                    }
                });
        ScheduledThreadPoolExecutor executor = new ScheduledThreadPoolExecutor(10);
        executor.scheduleAtFixedRate(() -> gameState.arena.shrinkLifeArea(),
                LIVE_ZONE_SHRINK_PERIOD,
                LIVE_ZONE_SHRINK_PERIOD,
                TimeUnit.MILLISECONDS);

        executor.scheduleAtFixedRate(() -> {
                    // every 50 ms send to all players event with new gamestate
                    server.getBroadcastOperations().sendEvent("chatevent", gameState);
                }, 0, SEND_STATE_PERIOD, TimeUnit.MILLISECONDS
        );

        log.info("SERVER START");
        server.start();

        // server.stop();
    }

}
