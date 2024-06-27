package org.example.entity.spell.debuff;

import org.example.entity.Player;
import org.example.entity.spell.Spell;

import java.util.List;

public abstract class DebuffSpell implements Spell {

    @Override
    public void processSpell(List<Player> all, Player from, Object... args) {
        debuffPlayer((Player) args[0]);
    }

    abstract void debuffPlayer(Player player);
}
