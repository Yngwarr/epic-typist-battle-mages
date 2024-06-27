package org.example.events.in_progress;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.listener.DataListener;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.Game;
import org.example.GameStatus;
import org.example.dto.CloseDto;

@AllArgsConstructor
@Slf4j
public class CloseEvent implements DataListener<CloseDto> {

    private final Game game;

    @Override
    public void onData(SocketIOClient socketIOClient, CloseDto data, AckRequest ackRequest) {
        if (data == null || data.getId() == null) {
            return;
        }
        game.players.removeIf(p -> (p != null) && (p.getId() != null) && (p.getId().equals(data.getId())));
        game.gameState.setPlayers(game.players);

        if (game.players.isEmpty()) {
            game.gameState.setStatus(GameStatus.PREPARATION);
            game.setStatus(GameStatus.PREPARATION);
        }
    }

}
