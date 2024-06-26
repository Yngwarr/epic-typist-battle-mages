package org.example.utils;

import java.util.concurrent.ThreadLocalRandom;

public class MathUtils {

    public static int randomInt(int max) {
        return randomInt(0, max);
    }

    public static int randomInt(int min, int max) {
        return ThreadLocalRandom.current().nextInt(min, max + 1);
    }
}
