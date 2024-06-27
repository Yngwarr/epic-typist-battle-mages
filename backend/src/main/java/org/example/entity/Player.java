package org.example.entity;

import lombok.*;

import java.util.UUID;

import java.util.ArrayList;

@Getter
@Setter
@AllArgsConstructor
@ToString
public class Player {
    private String id;
    private int hp = 100;
    private String name;
    private int x;
    private int y;
    private boolean alive = true;
    private UUID lastSessionId;

    public Player(String name,
                  Coordinates coordinates,
                  UUID sessionId
                  ) {
        this.name = name;
        this.id = UUID.randomUUID().toString();
        this.x = coordinates.getX();
        this.y = coordinates.getY();
        this.lastSessionId = sessionId;
    }
    private ArrayList<Debuff> debuffs = new ArrayList<>();

    public Player minusHp(int hp) {
        if (alive) {
            this.hp -= hp;
            if (hp <= 0) {
                this.alive = false;
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

}
