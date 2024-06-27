extends Node2D

enum ArrowDirection {
	UP,
	RIGHT,
	DOWN,
	LEFT,
}

@export var direction : ArrowDirection = ArrowDirection.UP

@onready var character_label : Label = $CharacterLabel

func _ready() -> void:
	rotation_degrees = direction * 90
	character_label.rotation_degrees = direction * -90

func set_character(char: String) -> void:
	character_label.text = char
