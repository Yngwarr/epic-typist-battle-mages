package org.example.events.preparation;

import com.corundumstudio.socketio.AckCallback;
import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.listener.DataListener;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.Game;
import org.example.GameStatus;
import org.example.dto.PlayerDto;
import org.example.entity.Player;

import java.util.ArrayList;

@Slf4j
@AllArgsConstructor
public class NewPlayerEvent implements DataListener<PlayerDto> {

    private final Game game;

    @Override
    public void onData(SocketIOClient client, PlayerDto data, AckRequest ackRequest) throws Exception {
        if (game.status.equals(GameStatus.IN_PROGRESS)) {
            return;
        }

        if (game.status.equals(GameStatus.OVER)) {
            game.setStatus(GameStatus.PREPARATION);
            game.getGameState().setStatus(GameStatus.PREPARATION);
        }

        if (data == null) {
            return;
        }
        var name = data.getName();
        log.info("New player with name {}", name);
        Player newPlayer = game.addPlayer(name, client.getSessionId());

        client.set("player_id", newPlayer.getId());

        log.info("Added player {}", newPlayer);
        ackRequest.sendAckData(newPlayer);
        client.sendEvent("newPlayer", new AckCallback<>(String.class) {
            @Override
            public void onSuccess(String result) {
                System.out.println("ack from client: " + client.getSessionId() + " data: " + result);
            }
        }, newPlayer);

    }
}
