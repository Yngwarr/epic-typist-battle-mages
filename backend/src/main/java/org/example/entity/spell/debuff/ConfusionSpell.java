package org.example.entity.spell.debuff;

import org.example.entity.Debuff;
import org.example.entity.Player;

import java.time.ZonedDateTime;

public class ConfusionSpell implements DebuffSpell {

    private Debuff debuff;

    private final int DURATION_SECONDS = 20;

    public ConfusionSpell() {
        this.debuff = new Debuff("CONFUSION", ZonedDateTime.now().toString(), ZonedDateTime.now().plusSeconds(DURATION_SECONDS).toString());
    }

    public void debuffPlayer(Player player) {
        player.getDebuffs().add(debuff);
    }

    @Override
    public void processSpell(Player from, Player to) {
        debuffPlayer(to);
    }
}
