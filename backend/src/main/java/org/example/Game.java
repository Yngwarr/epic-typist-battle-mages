package org.example;

import org.example.entity.Direction;
import org.example.entity.GameState;
import org.example.entity.Player;

import java.util.ArrayList;
import java.util.Objects;
import java.util.zip.ZipEntry;

public class Game {
    public ArrayList<Player> players;

    public byte[] map;

    public Game() {
        this.map = new byte[200*200];
        this.players = new ArrayList<>();
    }

    public int xyToIndex(int x, int y) {
        return y*200+x;
    }

    public boolean addPlayer(Player player) {
        var x = player.getX();
        var y = player.getY();
        this.players.add(player);
        var i = xyToIndex(x, y);
        if (map[i] == 1){
            return false;
        }
        this.map[i] = 1;
        return true;
    }

    public GameState getState(){
        return new GameState(this.players);
    }

    public Player getPlayerById(String id){
        var maybePlayer = this.players.stream().filter(p -> Objects.equals(p.getId(), id)).findFirst();
        return maybePlayer.orElse(null);
    }

    public void movePlayer(Player player, Direction direction){
        var x = player.getX();
        var y = player.getY();
        // TODO: overflow
        switch (direction){
            case Direction.UP:
                player.setX(y-1);
                break;
            case Direction.DOWN:
                player.setX(y+1);
                break;
            case Direction.LEFT:
                player.setY(y-1);
                break;
            case Direction.RIGHT:
                player.setY(y+1);
                break;
        }
    }
}
