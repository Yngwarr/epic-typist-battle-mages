package org.example.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@ToString
public class Player {
    private String id;
    private int hp;
    private String name;
    private int x;
    private int y;
    private boolean alive;

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
