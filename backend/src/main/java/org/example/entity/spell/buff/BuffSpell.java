package org.example.entity.spell.buff;

import org.example.entity.Player;
import org.example.entity.spell.Spell;

import java.util.List;

public abstract class BuffSpell implements Spell {

    public abstract void buffPlayer(Player from);

    @Override
    public void processSpell(List<Player> all, Player from, Object... args) {
        buffPlayer(from);
    }
}
