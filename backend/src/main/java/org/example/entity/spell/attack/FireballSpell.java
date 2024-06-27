package org.example.entity.spell.attack;

import lombok.ToString;
import org.example.entity.Player;

import java.util.List;

@ToString
public class FireballSpell implements DamageSpell {

    public int damage = 20;

    @Override
    public void processSpell(List<Player> all, Player from, Player to) {
        dealDamage(all, from, to);
    }

    @Override
    public void dealDamage(List<Player> all, Player from, Player to) {
        to.minusHp(damage);

    }
}
