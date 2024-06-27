package org.example.entity.spell.debuff;

import org.example.entity.Debuff;
import org.example.entity.Player;

import java.time.ZonedDateTime;
import java.util.List;

public class StickinessSpell extends DebuffSpell {
    private final Debuff debuff;

    private static final int DURATION_SECONDS = 20;

    public StickinessSpell() {
        this.debuff = new Debuff("STICKINESS", ZonedDateTime.now(), ZonedDateTime.now().plusSeconds(DURATION_SECONDS));
    }

    @Override
    public void debuffPlayer(Player player) {
        player.getDebuffs().add(debuff);
    }
}
