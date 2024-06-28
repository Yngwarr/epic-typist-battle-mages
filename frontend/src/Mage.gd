class_name Mage
extends Node2D

@export var skins: Array[Texture2D]
@export var sound_player: AudioStreamPlayer2D
@export var move_sfx: AudioStream

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var view: Sprite2D = $View

@onready var magic_essence : Sprite2D = $MagicEssence

func _ready() -> void:
	play_idle_animation()

func play_idle_animation() -> void:
	anim.play(&"idle")
	#magic_essence.hide()

func set_skin(id: String) -> void:
	var skin_code := hash(id) % len(skins)
	view.texture = skins[skin_code]

func play_taken_damage_animation() -> void:
	anim.play(&"taking_damage")
	#magic_essence.hide()

func play_cast_end_animation() -> void:
	anim.play(&"cast_end")
	#magic_essence.show()

func play_cast_animation() -> void:
	anim.play(&"cast")
	#magic_essence.show()

func step() -> void:
	sound_player.stream = move_sfx
	sound_player.play()

func die() -> void:
	anim.play(&"die")
