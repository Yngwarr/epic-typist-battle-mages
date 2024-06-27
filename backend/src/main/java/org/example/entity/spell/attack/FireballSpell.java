package org.example.entity.spell.attack;

import lombok.ToString;
import org.example.entity.Player;

@ToString
public class FireballSpell implements DamageSpell {

    public int damage = 20;
    @Override
    public void dealDamage(Player from, Player to) {
        to.minusHp(damage);
    }

    @Override
    public void processSpell(Player from, Player to) {
        dealDamage(from, to);
    }
}
