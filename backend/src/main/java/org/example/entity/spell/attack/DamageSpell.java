package org.example.entity.spell.attack;

import org.example.entity.Player;
import org.example.entity.spell.Spell;

import java.util.List;

public abstract class DamageSpell implements Spell {
    @Override
    public void processSpell(List<Player> all, Player from, Object... args) {
        dealDamage(all, from, args);
    }

    public abstract void dealDamage(List<Player> all, Player from, Object[] args);
}
