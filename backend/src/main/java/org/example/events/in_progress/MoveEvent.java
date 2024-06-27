package org.example.events.in_progress;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.listener.DataListener;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.Game;
import org.example.GameStatus;
import org.example.dto.MoveDto;
import org.example.entity.Direction;

@AllArgsConstructor
@Slf4j
public class MoveEvent implements DataListener<MoveDto> {

    private final Game game;

    @Override
    public void onData(SocketIOClient socketIOClient, MoveDto data, AckRequest ackRequest) {
        if (!game.status.equals(GameStatus.IN_PROGRESS)) {
            return;
        }
        if (data == null) {
            return;
        }
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
}
