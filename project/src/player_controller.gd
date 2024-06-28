class_name PlayerController
extends Pawn

var lost := false
var grid_size: float
var alive := true
var hp := 100

@onready var mage: Mage = $Mage
@onready var up_arrow := $UpArrow
@onready var down_arrow := $DownArrow
@onready var left_arrow := $LeftArrow
@onready var right_arrow := $RightArrow

@onready var parent := get_parent()
#@onready var animation_playback: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
#@onready var walk_animation_time: float = $AnimationPlayer.get_animation("walk").length


#func _input(event: InputEvent) -> void:
	#var vector := Vector2i.ZERO
	#
	#if event.is_action_released("ui_up"):
		#vector.y -= 1
	#if event.is_action_released("ui_down"):
		#vector.y += 1
	#if event.is_action_released("ui_right"):
		#vector.x += 1
	#if event.is_action_released("ui_left"):
		#vector.x -= 1
#
	#if vector == Vector2i.ZERO:
		#return
#
	#var target_position: Vector2 = parent.request_move(self, vector)
	#if target_position:
		##move_to(target_position)
		#SocketClient.move(vector)

func _ready() -> void:
	mage.set_skin(Global.self_id)

func update_look_direction(direction: Vector2) -> void:
	$Pivot/Sprite2D.rotation = direction.angle()

func set_arrows_label(up: String, down: String, left: String, right: String) -> void:
	up_arrow.set_character(up)
	down_arrow.set_character(down)
	left_arrow.set_character(left)
	right_arrow.set_character(right)

func show_arrows() -> void:
	up_arrow.show()
	down_arrow.show()
	left_arrow.show()
	right_arrow.show()

func hide_arrows() -> void:
	up_arrow.hide()
	down_arrow.hide()
	left_arrow.hide()
	right_arrow.hide()

func move(vector: Vector2i) -> void:
	var target_position: Vector2 = parent.request_move(self, vector)
	if target_position:
		#move_to(target_position)
		SocketClient.move(vector)

func register_char_up_arrow(char: String) -> bool:
	return up_arrow.register_char(char)

func register_char_down_arrow(char: String) -> bool:
	return down_arrow.register_char(char)

func register_char_left_arrow(char: String) -> bool:
	return left_arrow.register_char(char)

func register_char_right_arrow(char: String) -> bool:
	return right_arrow.register_char(char)

func clear_up_arrow_state() -> void:
	up_arrow.clear_entered_text_state()

func clear_down_arrow_state() -> void:
	down_arrow.clear_entered_text_state()

func clear_left_arrow_state() -> void:
	left_arrow.clear_entered_text_state()

func clear_right_arrow_state() -> void:
	right_arrow.clear_entered_text_state()

func play_taken_damage_animation() -> void:
	mage.play_taken_damage_animation()

func move_to(target_position: Vector2) -> void:
	#set_process(false)
	#var move_direction := (target_position - position).normalized()
	#animation_playback.start("walk")
#
	#var tween := create_tween()
	#tween.set_ease(Tween.EASE_IN)
	#var end: Vector2 = $Pivot.position + move_direction * grid_size
	#tween.tween_property($Pivot, "position", end, walk_animation_time)
#
	#await tween.finished
	#$Pivot.position = Vector2.ZERO
	position = target_position
	#animation_playback.start("idle")
#
	#set_process(true)


#func bump() -> void:
	#set_process(false)
	#animation_playback.start("bump")
	#await $AnimationTree.animation_finished
	#animation_playback.start("idle")
	#set_process(true)
