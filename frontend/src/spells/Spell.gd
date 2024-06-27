@tool
class_name Spell
extends Node2D

#@export var icon : Texture

var description : SpellDescription

@export var number : int

#@onready var icon_sprite : Sprite2D = $Icon
#
func _ready() -> void:
	$Sprite2D/Label.text = str(number)
