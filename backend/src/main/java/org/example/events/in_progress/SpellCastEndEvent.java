package org.example.events.in_progress;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.listener.DataListener;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.Game;
import org.example.GameStatus;
import org.example.dto.CastSpellDto;
import org.example.entity.spell.SpellFabric;

@Slf4j
@AllArgsConstructor
public class SpellCastEndEvent implements DataListener<CastSpellDto> {

    private final Game game;

    @Override
    public void onData(SocketIOClient socketIOClient, CastSpellDto data, AckRequest ackRequest) {
        if (!game.status.equals(GameStatus.IN_PROGRESS)) {
            return;
        }

        if (data == null) {
            log.info("cast end: no data");
            return;
        }
        var from = game.getPlayerById(data.playerFromId);
        if (from == null || !from.isAlive()) {
            logDeadCaster(data);
            return;
        }

        log.info("got spellCasted: {}", data);
        var spellname = data.spellName;
        var to = data.playerToId;
        var maybePlayer = game.getPlayerById(to);
        if (maybePlayer == null) {
            maybePlayer = from;
        }
        var spell = SpellFabric.getSpell(spellname);

        game.spellsInProgress.removeIf(s ->
                    ( (s.getSpellName() != null) && (data.getSpellName() != null)
                            && s.getSpellName().equals(data.getSpellName()))
                            && ( (s.getPlayerToId() != null) && (data.getPlayerToId() != null)
                            && s.getPlayerToId().equals(data.getPlayerToId()))
                            && ( (s.getPlayerFromId() != null) && (data.getPlayerFromId() != null)
                            && s.getPlayerFromId().equals(data.getPlayerFromId()))
        );
        spell.processSpell(game.getPlayers(), from, maybePlayer);
        log.info("deal damage to {}", maybePlayer);
    }

    private static void logDeadCaster(CastSpellDto data) {
        log.info("cast is not successful (caster is dead). spell {}", data);
    }
}
