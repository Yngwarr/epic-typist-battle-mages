package org.example.entity.spell.attack;

import lombok.ToString;
import org.example.entity.Player;

@ToString
public class MagicMissleSpell implements DamageSpell {

    public int damage = 5;
    @Override
    public void dealDamage(Player from, Player to) {
        to.minusHp(damage);
    }

    @Override
    public void processSpell(Player from, Player to) {
        dealDamage(from, to);
    }
}
