package org.example;

import org.example.entity.Arena;
import org.example.entity.Direction;
import org.example.entity.GameState;
import org.example.entity.Player;
import org.example.entity.spell.DamageSpell;

import java.util.ArrayList;
import java.util.Objects;

public class Game {
    public static final int DEFAULT_ARENA_SIZE = 10;
    public Arena arena;
    public ArrayList<Player> players;
    public GameState gameState;
    public ArrayList<DamageSpell> spellsInProgress = new ArrayList<>();

    public Game() {
        this.players = new ArrayList<>();
        this.arena = new Arena(DEFAULT_ARENA_SIZE);
        this.gameState = new GameState(players, arena, this.spellsInProgress);
    }

    public int xyToIndex(int x, int y) {
        return y * 200 + x;
    }

    public void addPlayer(Player player) {
        this.players.add(player);
    }

    public GameState getState() {
        return this.gameState;
    }

    public Player getPlayerById(String id) {
        var maybePlayer = this.players.stream().filter(p -> Objects.equals(p.getId(), id)).findFirst();
        return maybePlayer.orElse(null);
    }

    public void movePlayer(Player player, Direction direction) {
        var x = player.getX();
        var y = player.getY();
        // TODO: overflow
        switch (direction) {
            case Direction.UP:
                player.setY(y - 1);
                break;
            case Direction.DOWN:
                player.setY(y + 1);
                break;

            case Direction.LEFT:
                player.setX(x - 1);
                break;
            case Direction.RIGHT:
                player.setX(x + 1);
                break;
        }
    }
}
