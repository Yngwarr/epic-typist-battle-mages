package org.example.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.example.utils.MathUtils;

@AllArgsConstructor
@Getter
@Setter
@Builder
public class Arena {

    private static final int MIN_SIZE = 5;

    private static int remoteness(int centerX, int centerY, int arenaSize) {
        int remotenessX = Math.max(arenaSize - centerX - 1, centerX);
        int remotenessY = Math.max(arenaSize - centerY - 1, centerY);
        return Math.max(remotenessX, remotenessY);
    }

    public Arena(int originalSize) {
        this.originalSize = originalSize;
        // прям настолько рандомно?
        this.centerX = MathUtils.randomInt(originalSize - 1);
        this.centerY = MathUtils.randomInt(originalSize - 1);
        this.lifeRadius = remoteness(centerX, centerY, originalSize);
    }

    public int centerX;
    public int centerY;
    public int lifeRadius;
    public int originalSize;

    public void shrinkLifeArea() {
        if (lifeRadius > MIN_SIZE) {
            lifeRadius--;
        }
    }

}
