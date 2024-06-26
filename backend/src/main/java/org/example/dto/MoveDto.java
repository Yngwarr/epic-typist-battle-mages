package org.example.dto;

import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
public class MoveDto {
    String playerId;
    String command;
    String direction;
}
