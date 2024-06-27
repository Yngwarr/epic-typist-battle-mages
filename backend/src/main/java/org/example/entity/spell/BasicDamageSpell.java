package org.example.entity.spell;

import lombok.ToString;
import org.example.entity.Player;

// fireball
@ToString
public class BasicDamageSpell implements DamageSpell {

    public int damage = 10;
    @Override
    public void dealDamage(Player from, Player to) {
        to.minusHp(damage);
    }

    @Override
    public void processSpell(Player from, Player to) {
        dealDamage(from, to);
    }
}
