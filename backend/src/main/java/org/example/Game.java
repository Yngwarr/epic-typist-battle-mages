package org.example;

import lombok.AllArgsConstructor;
import lombok.Builder;
import org.example.entity.Arena;
import org.example.entity.Direction;
import org.example.entity.GameState;
import org.example.entity.Player;
import org.example.entity.spell.DamageSpell;

import java.util.ArrayList;
import java.util.Objects;

@AllArgsConstructor
@Builder
public class Game {
    private static final int DEFAULT_ARENA_SIZE = 10;
    private static final int DEAD_ZONE_TICK_DAMAGE = 5;

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

    boolean isInsideDeadZone(Player player) {
        return isInsideDeadZoneX(player.getX()) ||
                isInsideDeadZoneY(player.getY());
    }

    private boolean isInsideDeadZoneX(int x) {
        return x < arena.centerX - arena.lifeRadius ||
                x > arena.centerX + arena.lifeRadius;
    }

    private boolean isInsideDeadZoneY(int y) {
        return y < arena.centerY - arena.lifeRadius ||
                y > arena.centerY + arena.lifeRadius;
    }

    public void deadZoneTick() {
        players.stream()
                .filter(this::isInsideDeadZone)
                .forEach(p -> p.minusHp(DEAD_ZONE_TICK_DAMAGE));
    }
}
