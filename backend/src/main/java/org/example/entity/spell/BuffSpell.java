package org.example.entity.spell;

import org.example.entity.Player;

public interface BuffSpell extends Spell {
    void buffPlayer(Player player);
}
