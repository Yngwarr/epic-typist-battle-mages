package org.example.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.example.GameStatus;
import org.example.dto.CastSpellDto;

import java.util.ArrayList;
import java.util.Set;

@Setter
@Getter
@AllArgsConstructor
@Builder
public class GameState {
    public ArrayList<Player> players;
    public Arena arena;
    public GameStatus status;
    public Set<CastSpellDto> spellsInProgress;
}
