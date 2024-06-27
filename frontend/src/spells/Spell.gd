@tool
class_name Spell
extends Node2D

#@export var icon : Texture

var description : SpellDescription

#@onready var icon_sprite : Sprite2D = $Icon
#
#func _ready() -> void:
	#icon_sprite.texture = icon
