class_name Mage
extends Node2D

@export var skins: Array[Texture2D]

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var view: Sprite2D = $View

func _ready() -> void:
	anim.play(&"idle")

func set_skin(id: String) -> void:
	var skin_code := hash(id) % len(skins)
	view.texture = skins[skin_code]
