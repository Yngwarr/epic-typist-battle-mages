package org.example.events.preparation;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.listener.DataListener;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.Game;
import org.example.dto.StartGameDto;

@Slf4j
@AllArgsConstructor
public class StartGameEvent implements DataListener<StartGameDto> {

    private final Game game;

    @Override
    public void onData(SocketIOClient socketIOClient, StartGameDto startGameDto, AckRequest ackRequest) {
        game.start();
    }
}
