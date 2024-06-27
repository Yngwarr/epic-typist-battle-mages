package org.example.entity.spell.attack;

import org.example.entity.Player;

import java.util.List;

public class ExplosionSpell extends DamageSpell {

    public static int damage = 10;
    public static int radius = 4;

    @Override
    public void dealDamage(List<Player> all, Player from, Object[] args) {
        all.stream()
                .filter(player -> isCloseEnoughEnemy(from, player))
                .forEach(p -> p.minusHp(damage));
    }

    private static boolean isInRadius(int a, int b) {
        return Math.abs(a - b) <= radius;
    }

    private boolean isCloseEnoughEnemy(Player from, Player to) {
        if (from.equals(to)) {
            return false;
        }

        return isInRadius(from.getX(), to.getX()) &&
                isInRadius(from.getY(), to.getY());
    }
}
