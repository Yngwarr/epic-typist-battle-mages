extends Node2D

enum ArrowDirection {
	UP,
	RIGHT,
	DOWN,
	LEFT,
}

@export var direction : ArrowDirection = ArrowDirection.UP

@onready var character_label : SpellText = $SpellText

func _ready() -> void:
	rotation_degrees = direction * 90
	character_label.rotation_degrees = direction * -90

func set_character(text: String) -> void:
	character_label.set_spell_text(text)

func register_char(char: String) -> bool:
	return character_label.register_character(char)

func clear_entered_text_state() -> void:
	character_label.clear_entered_state()
