package org.example.entity.spell;

import org.example.entity.Player;

import java.util.List;

public interface Spell {
    void processSpell(List<Player> all, Player from, Object... args);

}
