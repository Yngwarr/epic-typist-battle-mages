package org.example;

import lombok.AllArgsConstructor;
import lombok.Builder;
import org.example.dto.CastSpellDto;
import org.example.entity.*;
import org.example.utils.MathUtils;

import java.util.*;

@AllArgsConstructor
@Builder
public class Game {
    private static final int DEFAULT_ARENA_SIZE = 10;
    private static final int DEAD_ZONE_TICK_DAMAGE = 5;

    public Arena arena;
    public ArrayList<Player> players;
    public GameState gameState;
    public Set<CastSpellDto> spellsInProgress = new HashSet<>();

    public Game() {
        this.players = new ArrayList<>();
        this.arena = new Arena(DEFAULT_ARENA_SIZE);
        this.gameState = new GameState(players, arena, this.spellsInProgress);
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

    public Coordinates randomCoordinatesOnCorner(int arenaSquareSize){
        return new Coordinates(MathUtils.randomInt(arenaSquareSize), MathUtils.randomInt(arenaSquareSize));
    }
    public Coordinates randomCoordinatesOnCorner(){
        return randomCoordinatesOnCorner(DEFAULT_ARENA_SIZE);
    }

    public Coordinates goodCoordinates(){
        Coordinates coords = this.randomCoordinatesOnCorner();
        if (this.players.stream().anyMatch(p -> (p.getX() == coords.getX()) && (p.getY() == coords.getY()))) {
            return goodCoordinates();
        }
        else return coords;
    }

    public Player addPlayer(String name, UUID sessionId) {
        var p = new Player(name, goodCoordinates(), sessionId);
        players.add(p);
        return p;
    }

    public void removePlayer(UUID sessionId) {
        players.removeIf(p -> p.getLastSessionId().equals(sessionId));
    }
}
