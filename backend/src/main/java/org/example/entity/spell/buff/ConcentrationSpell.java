package org.example.entity.spell.buff;

import org.example.entity.Buff;
import org.example.entity.Player;

import java.time.ZonedDateTime;

public class ConcentrationSpell extends BuffSpell {

    private final Buff buff;

    private static final int DURATION_SECONDS = 20;

    @Override
    public void buffPlayer(Player player) {
        player.getBuffs().add(buff);
    }

    public ConcentrationSpell() {
        this.buff = new Buff("CONCENTRATION",
                ZonedDateTime.now(),
                ZonedDateTime.now().plusSeconds(DURATION_SECONDS));
    }
}
