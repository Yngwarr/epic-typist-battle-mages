package org.example.entity.spell;

import org.example.entity.Player;

// fireball
public class BasicDamageSpell implements DamageSpell {

    public int damage = 10;
    @Override
    public void dealDamage(Player from, Player to) {
        to.minusHp(damage);
    }
}
