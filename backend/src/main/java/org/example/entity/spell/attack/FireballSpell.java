package org.example.entity.spell.attack;

import lombok.ToString;
import org.example.entity.Player;

import java.util.List;

@ToString
public class FireballSpell extends DamageSpell {

    public int damage = 20;

    @Override
    public void dealDamage(List<Player> all, Player from, Object[] args) {
        ((Player) args[0]).minusHp(damage);
    }
}
