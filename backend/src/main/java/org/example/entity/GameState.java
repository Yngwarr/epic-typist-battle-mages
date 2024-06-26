package org.example.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.example.entity.spell.DamageSpell;

import java.util.ArrayList;

@Setter
@Getter
@AllArgsConstructor
public class GameState {
    public ArrayList<Player> players;
    public Arena arena;
    public ArrayList<DamageSpell> spellsInProgress;
}
