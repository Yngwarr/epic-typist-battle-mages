package org.example.main;

import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketIOServer;
import org.example.Game;
import org.example.dto.MoveDto;
import org.example.entity.Direction;
import org.example.entity.GameState;
import org.example.entity.Player;

import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class ChatLauncher {

    public static void main(String[] args) throws InterruptedException {

        Configuration config = new Configuration();
        config.setHostname("localhost");
        config.setPort(9092);

        Game game = new Game();
        Player somePlayer = new Player("hui-id", 100, "Slava", 1, 1);
        game.addPlayer(somePlayer);
        GameState gameState = game.getState();

        final SocketIOServer server = new SocketIOServer(config);
        server.addEventListener("chatevent", MoveDto.class,
                (client, data, ackRequest) -> {
                    // broadcast messages to all clients
                    var playerId = data.getPlayerId();
                    var maybePlayer = game.getPlayerById(playerId);
                    if (maybePlayer != null) {
                        game.movePlayer(maybePlayer, Direction.valueOf(data.getDirection().toUpperCase()));
                    }
                });
        ScheduledThreadPoolExecutor executor = new ScheduledThreadPoolExecutor(10);
        executor.scheduleAtFixedRate(() -> {
                    // every 50 ms send to all players event with new gamestate
                    server.getBroadcastOperations().sendEvent("chatevent", gameState);
                }, 0, 50, TimeUnit.MILLISECONDS
        );

        server.start();

        // server.stop();
    }

}
