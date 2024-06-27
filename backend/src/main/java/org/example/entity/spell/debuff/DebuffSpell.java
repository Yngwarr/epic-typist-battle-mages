package org.example.entity.spell.debuff;

import org.example.entity.Player;
import org.example.entity.spell.Spell;

public interface DebuffSpell extends Spell {
    void debuffPlayer(Player player);
}
