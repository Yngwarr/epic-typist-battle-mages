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

    public Player minusHp(int hp){
        this.hp -= hp;
        return this;
    }

    public Player plusHp(int hp){
        this.hp += hp;
        return this;
    }

}
