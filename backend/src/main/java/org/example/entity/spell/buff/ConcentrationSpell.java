package org.example.entity.spell.buff;

import org.example.entity.Buff;
import org.example.entity.Player;

import java.time.ZonedDateTime;

public class ConcentrationSpell implements BuffSpell{

    private Buff buff;

    private final int DURATION_SECONDS = 20;
    @Override
    public void buffPlayer(Player player) {
        player.getBuffs().add(buff);
    }

    public ConcentrationSpell() {
        this.buff = new Buff("CONCENTRATION", ZonedDateTime.now().toString(), ZonedDateTime.now().plusSeconds(DURATION_SECONDS).toString());
    }

    @Override
    public void processSpell(Player from, Player to) {
        buffPlayer(to);
    }
}
