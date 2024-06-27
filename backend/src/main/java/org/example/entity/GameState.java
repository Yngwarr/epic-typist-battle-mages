package org.example.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.example.dto.CastSpellDto;

import java.util.ArrayList;
import java.util.Set;

@Setter
@Getter
@AllArgsConstructor
public class GameState {
    public ArrayList<Player> players;
    public Arena arena;
    public Set<CastSpellDto> spellsInProgress;
}
