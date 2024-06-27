package org.example.entity.spell;

import org.example.entity.Player;

public interface DebuffSpell extends Spell{
    void debuffPlayer(Player player);
}
