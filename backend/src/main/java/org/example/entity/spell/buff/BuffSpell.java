package org.example.entity.spell.buff;

import org.example.entity.Player;
import org.example.entity.spell.Spell;

public interface BuffSpell extends Spell {
    void buffPlayer(Player player);
}
