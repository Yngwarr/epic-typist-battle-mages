package org.example.entity.spell.debuff;

import org.example.entity.Debuff;
import org.example.entity.Player;

import java.time.ZonedDateTime;

public class ConfusionSpell extends DebuffSpell {

    private final Debuff debuff;

    private static final int DURATION_SECONDS = 20;

    public ConfusionSpell() {
        this.debuff = new Debuff("CONFUSION", ZonedDateTime.now(), ZonedDateTime.now().plusSeconds(DURATION_SECONDS));
    }

    @Override
    public void debuffPlayer(Player player) {
        player.getDebuffs().add(debuff);
    }
}
