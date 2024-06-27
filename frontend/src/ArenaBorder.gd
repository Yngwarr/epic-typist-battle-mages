class_name ArenaBorder
extends Node2D

const TILE_SIZE: int = 128

@onready var left: Sprite2D = $Left
@onready var right: Sprite2D = $Right
@onready var up: Sprite2D = $Up
@onready var down: Sprite2D = $Down

func resize(center: Vector2i, radius: int, original_radius: int) -> void:
    left.position.x = 0
    left.position.y = 0
    left.scale.x = (center.x - radius) * TILE_SIZE
    left.scale.y = original_radius * TILE_SIZE

    right.position.x = (center.x + radius) * TILE_SIZE
    right.position.y = 0
    right.scale.x = original_radius * TILE_SIZE - right.position.x
    right.scale.y = original_radius * TILE_SIZE

    up.position.x = left.scale.x
    up.position.y = 0
    up.scale.x = (2 * radius) * TILE_SIZE
    up.scale.y = (center.y - radius) * TILE_SIZE

    down.position.x = left.scale.x
    down.position.y = up.scale.x + 2 * radius * TILE_SIZE
    down.scale.x = up.scale.x
    down.scale.y = original_radius * TILE_SIZE - down.position.y
