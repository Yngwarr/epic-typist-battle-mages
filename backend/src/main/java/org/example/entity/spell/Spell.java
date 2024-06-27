package org.example.entity.spell;

import org.example.entity.Player;

public interface Spell {
    void processSpell(Player from, Player to);
}
