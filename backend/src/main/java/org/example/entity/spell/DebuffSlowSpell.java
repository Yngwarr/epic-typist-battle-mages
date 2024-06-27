package org.example.entity.spell;

import org.example.entity.Debuff;
import org.example.entity.Player;

import java.time.ZonedDateTime;

public class DebuffSlowSpell implements DebuffSpell {
    private Debuff debuff;

    private int DURACTION_SECONDS = 20;

    public DebuffSlowSpell() {
        this.debuff = new Debuff("DebuffSlow", ZonedDateTime.now().toString(), ZonedDateTime.now().plusSeconds(DURACTION_SECONDS).toString());
    }

    public void debuffPlayer(Player player) {
        player.getDebuffs().add(debuff);
    }

    @Override
    public void processSpell(Player from, Player to) {
        debuffPlayer(to);
    }
}
