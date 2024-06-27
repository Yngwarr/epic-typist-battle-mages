package org.example.entity.spell.attack;

import org.example.entity.Player;
import org.example.entity.spell.Spell;

import java.util.List;

public interface DamageSpell extends Spell {
    void dealDamage(List<Player> all, Player from, Player to);
}
