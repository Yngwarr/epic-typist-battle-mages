class_name Mage
extends Node2D

@export var skins: Array[Texture2D]
@export var sound_player: AudioStreamPlayer2D
@export var move_sfx: AudioStream

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var view: Sprite2D = $View

func _ready() -> void:
	anim.play(&"idle")

func set_skin(id: String) -> void:
	var skin_code := hash(id) % len(skins)
	view.texture = skins[skin_code]

func play_taken_damage_animation() -> void:
	anim.play(&"taking_damage")
	anim.queue(&"idle")

func step() -> void:
	sound_player.stream = move_sfx
	sound_player.play()

func die() -> void:
	anim.play(&"die")
