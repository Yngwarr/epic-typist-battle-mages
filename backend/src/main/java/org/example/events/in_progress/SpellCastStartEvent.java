package org.example.events.in_progress;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.listener.DataListener;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.Game;
import org.example.dto.CastSpellDto;

@Slf4j
@AllArgsConstructor
public class SpellCastStartEvent implements DataListener<CastSpellDto> {

    private final Game game;

    @Override
    public void onData(SocketIOClient socketIOClient, CastSpellDto data, AckRequest ackRequest) throws Exception {
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
    }

    private static void logDeadCaster(CastSpellDto data) {
        log.info("cast is not successful (caster is dead). spell {}", data);
    }
}
