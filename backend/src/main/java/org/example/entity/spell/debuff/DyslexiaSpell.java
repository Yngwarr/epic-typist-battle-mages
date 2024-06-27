package org.example.entity.spell.debuff;

import org.example.entity.Debuff;
import org.example.entity.Player;

import java.time.ZonedDateTime;
import java.util.List;

public class DyslexiaSpell implements DebuffSpell {
    private Debuff debuff;

    private final int DURATION_SECONDS = 20;

    public DyslexiaSpell() {
        this.debuff = new Debuff("DYSLEXIA", ZonedDateTime.now().toString(), ZonedDateTime.now().plusSeconds(DURATION_SECONDS).toString());
    }

    public void debuffPlayer(Player player) {
        player.getDebuffs().add(debuff);
    }

    @Override
    public void processSpell(List<Player> all, Player from, Player to) {
        debuffPlayer(to);
    }
}
