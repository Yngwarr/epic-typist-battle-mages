package org.example;


import org.example.entity.Arena;
import org.example.entity.Coordinates;
import org.example.entity.Player;
import org.junit.Test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class GameTest {

    private Player dummyPlayer(int x, int y) {
        return new Player("dummy", new Coordinates(x, y));
    }

    @Test
    public void testIsInsideDeadZone() {
        Arena arena = Arena.builder()
                .originalSize(7)
                .centerX(2)
                .centerY(3)
                .lifeRadius(2)
                .build();

        Game game = Game.builder()
                .arena(arena)
                .build();

        assertTrue(game.isInsideDeadZone(dummyPlayer(0, 0)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(1, 0)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(2, 0)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(3, 0)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(4, 0)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(5, 0)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(6, 0)));

        assertFalse(game.isInsideDeadZone(dummyPlayer(0, 1)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(1, 1)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(2, 1)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(3, 1)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(4, 1)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(5, 1)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(6, 1)));

        assertFalse(game.isInsideDeadZone(dummyPlayer(0, 2)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(1, 2)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(2, 2)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(3, 2)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(4, 2)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(5, 2)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(6, 2)));

        assertFalse(game.isInsideDeadZone(dummyPlayer(0, 3)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(1, 3)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(2, 3)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(3, 3)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(4, 3)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(5, 3)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(6, 3)));

        assertFalse(game.isInsideDeadZone(dummyPlayer(0, 4)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(1, 4)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(2, 4)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(3, 4)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(4, 4)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(5, 4)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(6, 4)));

        assertFalse(game.isInsideDeadZone(dummyPlayer(0, 5)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(1, 5)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(2, 5)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(3, 5)));
        assertFalse(game.isInsideDeadZone(dummyPlayer(4, 5)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(5, 5)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(6, 5)));

        assertTrue(game.isInsideDeadZone(dummyPlayer(0, 6)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(1, 6)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(2, 6)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(3, 6)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(4, 6)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(5, 6)));
        assertTrue(game.isInsideDeadZone(dummyPlayer(6, 6)));


    }
}
