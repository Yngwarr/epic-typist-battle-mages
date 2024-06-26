package org.example.entity;

public class Player {
    private int hp;
    private String name;

    public Player minusHp(int hp){
        this.hp -= hp;
        return this;
    }

    public Player plusHp(int hp){
        this.hp += hp;
        return this;
    }

}
