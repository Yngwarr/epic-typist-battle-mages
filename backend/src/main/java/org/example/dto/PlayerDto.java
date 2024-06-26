package org.example.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class PlayerDto {
    String id;
    String name;
    int x;
    int y;
}
