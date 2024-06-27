package org.example.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import java.util.ArrayList;
import java.util.UUID;
import java.util.function.Consumer;

@Getter
@Setter
@AllArgsConstructor
@ToString
@Builder
public class Player {
    private static final int INIT_HP = 100;
    private String id;
    private int hp = INIT_HP;
    private String name;
    private int x;
    private int y;
    private boolean alive = true;

    private ArrayList<Debuff> debuffs = new ArrayList<>();
    private ArrayList<Buff> buffs = new ArrayList<>();

    @JsonIgnore
    private ArrayList<Consumer<Player>> onDeathListeners = new ArrayList<>();

    public void subscribeToDeath(Consumer<Player> onDeathListener) {
        this.onDeathListeners.add(onDeathListener);
    }

    public Player(String name, Coordinates coordinates) {
        this.name = name;
        this.id = UUID.randomUUID().toString();
        this.x = coordinates.getX();
        this.y = coordinates.getY();
    }

    private void die() {
        this.alive = false;
        this.onDeathListeners.forEach(listener -> listener.accept(this));
    }

    public Player minusHp(int hp) {
        if (alive) {
            this.hp -= hp;
            if (this.hp <= 0) {
                die();
            }
        }
        return this;
    }

    public Player plusHp(int hp) {
        if (alive) {
            this.hp += hp;
        }
        return this;
    }


    public void setNewPropsForNewGame(Coordinates coordinates){
        this.hp = INIT_HP;
        setX(coordinates.getX());
        setY(coordinates.getY());
        this.setAlive(true);
        this.setDebuffs(new ArrayList<>());
        this.setBuffs(new ArrayList<>());
    }

}
