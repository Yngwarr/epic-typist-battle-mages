class_name HUD
extends CanvasLayer

signal move_player_up()
signal move_player_down()
signal move_player_right()
signal move_player_left()
signal set_players_arrows(up: String, down: String, left: String, right: String)
signal show_player_arrows()
signal hide_player_arrows()


@onready var spell_list_panel := $SpellListPanel
@onready var casting_panel := $CastingPanel

var visible_enemies := {}

enum State {
	Targeting,
	Casting,
	Normal,
	Dead
}

var labeled_enemies := {}

var state : State = State.Normal


var up_key : String
var down_key : String
var left_key : String
var right_key : String

func _ready() -> void:
	casting_panel.hide()

func add_visible_enemy(player: Enemy) -> void:
	visible_enemies[player.id] = player
	if state == State.Targeting:
		var label := SymbolGeneration.generate_symbol(1)
		label_enemy(player, label)

func remove_visible_enemy(player: Enemy) -> void:
	if state == State.Targeting:
		player.set_target(false)
	visible_enemies.erase(player.id)

#func find_nearest_enemy(from: Vector2, enemies: Dictionary) -> Enemy:
	#var nearest_enemy : Enemy = null
	#var nearest_distance : float = 1e20
	#for enemy_key : String in visible_enemies:
		#var enemy : Enemy  = visible_enemies[enemy_key]
		#var distance := enemy.position.distance_squared_to(from)
		#if distance < nearest_distance:
			#nearest_enemy = enemy
			#nearest_distance = distance
	#return nearest_enemy

#func target_nearest_enemy() -> void:
	#var player : PlayerController = get_parent().self_player
	#var nearest_enemy : Enemy = find_nearest_enemy(player.position, visible_enemies)
	#nearest_enemy.set_target(true)
	#targeted_enemy = nearest_enemy



func label_visible_enemies() -> void:
	for enemy_key : String in visible_enemies:
		var enemy : Enemy  = visible_enemies[enemy_key]
		var label := SymbolGeneration.generate_symbol(1)
		label_enemy(enemy, label)

func label_enemy(enemy: Enemy, label: String) -> void:
	enemy.set_target_label(label)
	labeled_enemies[label] = enemy

func choose_target(spell: Spell) -> void:
	if spell == null:
		return
	state = State.Targeting
	hide_player_arrows.emit()
	SymbolGeneration.available_characters = range(65, 90)
	labeled_enemies.clear()
	label_visible_enemies()
	
func pick_enemy(str: String) -> void:
	if labeled_enemies.has(str):
		for enemy_key : String in labeled_enemies:
			var enemy : Enemy  = labeled_enemies[enemy_key]
			enemy.hide_target_label()
		enter_casting_state("hello world")

func enter_casting_state(text: String) -> void:
	state = State.Casting
	casting_panel.set_spell_text(text)
	casting_panel.show()

func move(text: String) -> void:
	if text == up_key:
		move_player_up.emit()
		generate_movement_labels()
	elif text == down_key:
		move_player_down.emit()
		generate_movement_labels()
	elif text == right_key:
		move_player_right.emit()
		generate_movement_labels()
	elif text == left_key:
		move_player_left.emit()
		generate_movement_labels()

func generate_movement_labels() -> void:
	SymbolGeneration.clear()
	up_key = SymbolGeneration.generate_symbol(1)
	down_key = SymbolGeneration.generate_symbol(1)
	left_key = SymbolGeneration.generate_symbol(1)
	right_key = SymbolGeneration.generate_symbol(1)
	set_players_arrows.emit(up_key, down_key, left_key, right_key)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match state:
			State.Normal:
				if event.keycode >= KEY_0 and event.keycode <= KEY_9:
					if event.keycode == KEY_0:
						choose_target(spell_list_panel.get_spell(9))
					else:
						choose_target(spell_list_panel.get_spell(event.keycode - 48 - 1))
				else:
					move(String.chr(event.keycode).to_lower())
			State.Casting:
				if event.keycode == KEY_BACKSPACE:
					casting_panel.delete_character()
				elif event.keycode == KEY_ESCAPE:
					casting_panel.hide()
					state = State.Normal
					get_viewport().set_input_as_handled()
				else:
					casting_panel.register_character(String.chr(event.unicode))
			State.Targeting:
				pick_enemy(String.chr(event.unicode).to_lower())
				

func _on_casting_panel__on_spell_casted() -> void:
	if state == State.Casting:
		casting_panel.hide()
		state = State.Normal
		show_player_arrows.emit()
		# TODO: Send end cast
