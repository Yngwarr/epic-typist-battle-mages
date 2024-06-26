package org.example.entity.spell;

import org.example.entity.Player;

public interface DamageSpell extends Spell {
    void dealDamage(Player player);
}
