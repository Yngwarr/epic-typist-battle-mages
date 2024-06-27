class_name PlayerController
extends Pawn

var lost := false
var grid_size: float

@onready var parent := get_parent()
#@onready var animation_playback: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
#@onready var walk_animation_time: float = $AnimationPlayer.get_animation("walk").length


func _input(event: InputEvent) -> void:
	var vector := Vector2i.ZERO
	if event.is_action_released("ui_up"):
		vector.y -= 1
	if event.is_action_released("ui_down"):
		vector.y += 1
	if event.is_action_released("ui_right"):
		vector.x += 1
	if event.is_action_released("ui_left"):
		vector.x -= 1

	if vector == Vector2i.ZERO:
		return

	SocketClient.move(vector)

	var target_position: Vector2 = parent.request_move(self, vector)
	if target_position:
		move_to(target_position)
#
#func _process(_delta: float) -> void:
	#var input_direction := get_input_direction()
	##print(input_direction)
	#if input_direction.is_zero_approx():
		#return
	#
	##update_look_direction(input_direction)
#
	#var target_position: Vector2 = parent.request_move(self, input_direction)
	#if target_position:
		#move_to(target_position)
	##elif active:
		##bump()

#
#func get_input_direction() -> Vector2:
	#return Vector2(
			#Input.action_release("ui_right") - Input.get_action_strength("ui_left"),
			#Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#)


func update_look_direction(direction: Vector2) -> void:
	$Pivot/Sprite2D.rotation = direction.angle()


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
