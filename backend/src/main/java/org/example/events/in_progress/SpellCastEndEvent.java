package org.example.events.in_progress;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.listener.DataListener;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.Game;
import org.example.dto.CastSpellDto;
import org.example.entity.spell.SpellFabric;

@Slf4j
@AllArgsConstructor
public class SpellCastEndEvent implements DataListener<CastSpellDto> {

    private final Game game;

    @Override
    public void onData(SocketIOClient socketIOClient, CastSpellDto data, AckRequest ackRequest) {
        if (!game.status.equals(Game.Status.IN_PROGRESS)) {
            return;
        }

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
    }

    private static void logDeadCaster(CastSpellDto data) {
        log.info("cast is not successful (caster is dead). spell {}", data);
    }
}
