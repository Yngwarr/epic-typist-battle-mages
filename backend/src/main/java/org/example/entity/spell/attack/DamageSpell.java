package org.example.entity.spell.attack;

import org.example.entity.Player;
import org.example.entity.spell.Spell;

public interface DamageSpell extends Spell {
    void dealDamage(Player from, Player to);
}
