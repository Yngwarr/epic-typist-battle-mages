package org.example;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.example.dto.CastSpellDto;
import org.example.entity.*;
import org.example.utils.MathUtils;

import java.time.Instant;
import java.util.*;

@AllArgsConstructor
@Builder
@Getter
@Setter
public class Game {

    private static final int DEFAULT_ARENA_SIZE = 10;
    private static final int DEAD_ZONE_TICK_DAMAGE = 5;

    public Arena arena;
    public ArrayList<Player> players;
    public GameState gameState;
    public Set<CastSpellDto> spellsInProgress = new HashSet<>();
    public GameStatus status = GameStatus.PREPARATION;
    public SortedMap<String, String> deathTimes = new TreeMap<>();

    public Game() {
        this.players = new ArrayList<>();
        this.arena = new Arena(DEFAULT_ARENA_SIZE);
        this.gameState = GameState.builder()
                .players(players)
                .arena(arena)
                .spellsInProgress(spellsInProgress)
                .status(status)
                .build();;
    }

    public void start() {
        this.players.forEach(p ->
                p.setNewPropsForNewGame(goodCoordinates()));
        this.gameState.setPlayers(this.players);
        this.status = GameStatus.IN_PROGRESS;
        this.gameState.setStatus(status);
    }

    public void end() {
        this.status = GameStatus.OVER;
        this.gameState.setStatus(status);
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
                .filter(p -> isInsideDeadZone(p) && p.isAlive())
                .forEach(p -> p.minusHp(DEAD_ZONE_TICK_DAMAGE));
    }

    public Coordinates randomCoordinatesOnCorner(int arenaSquareSize) {
        return new Coordinates(MathUtils.randomInt(arenaSquareSize), MathUtils.randomInt(arenaSquareSize));
    }

    public Coordinates randomCoordinatesOnCorner() {
        return randomCoordinatesOnCorner(DEFAULT_ARENA_SIZE);
    }

    public Coordinates goodCoordinates() {
        Coordinates coords = this.randomCoordinatesOnCorner();
        if (this.players.stream().anyMatch(p -> (p.getX() == coords.getX()) && (p.getY() == coords.getY()))) {
            return goodCoordinates();
        }
        return coords;
    }

    public void updateDeathTimes(Player p) {
        deathTimes.put(p.getName(), Instant.now().toString());
    }

    public Player addPlayer(String name, UUID sessionId) {
        var p = Player.builder()
                .id(UUID.randomUUID().toString())
                .lastSessionId(sessionId)
                .name(name)
                .onDeathListeners(new ArrayList<>())
                .build();
        p.subscribeToDeath(this::updateDeathTimes);
        players.add(p);
        return p;
    }

    public void removePlayer(UUID sessionId) {
        players.removeIf(p -> p.getLastSessionId().equals(sessionId));
    }

    public long countPlayersAlive() {
        return players.stream().filter(Player::isAlive).count();
    }
}
