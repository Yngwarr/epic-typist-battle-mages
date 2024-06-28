class_name HUD
extends CanvasLayer

signal move_player_up()
signal move_player_down()
signal move_player_right()
signal move_player_left()
signal set_players_arrows(up: String, down: String, left: String, right: String)
signal register_movement_character(char: String)
signal show_player_arrows()
signal hide_player_arrows()


@onready var spell_list_panel := $SpellListPanel
@onready var casting_panel := $CastingPanel
@onready var spell_text := $CastingPanel/MarginContainer/SpellText
@onready var healthbar := $Healthbar
@onready var name_label := $PlayerName

var visible_enemies := {}

enum State {
	Targeting,
	Casting,
	Normal,
	Dead
}

var labeled_enemies := {}

var state : State = State.Normal

var target_enemy : Enemy
var chosen_spell : SpellDescription

var up_key : String
var down_key : String
var left_key : String
var right_key : String

var debuffs := []
var buffs := []

var entered_movement_text : String = ""

var applied_debuffs := {}

var player_controller : PlayerController

func _ready() -> void:
	casting_panel.hide()
	player_controller = get_parent().self_player
	name_label.text = Global.self_name

func generate_word() -> Array[String]:
	if check_debuff("DYSLEXIA"):
		return Words.get_words_with_random_symbols(1)
	else:
		return Words.get_words(1)

func generate_words(count: int) -> Array[String]:
	if check_debuff("CONFUSION"):
		count += 1
	if check_buff("CONCENTRATION"):
		count -= 1
	if check_debuff("DYSLEXIA"):
		return Words.get_words_with_random_symbols(count)
	else:
		return Words.get_words(count)

func apply_debuff(name: String) -> void:
	match name:
		"STICKINESS":
			generate_movement_labels()
		"CONFUSION":
			if state == State.Casting:
				var word := generate_word()
				spell_text.append_spell_text(word[0])
		"DYSLEXIA":
			if state == State.Casting:
				var spell_word_count := spell_difficulty_word_count(chosen_spell.difficulty)
				var words := generate_words(spell_word_count)
				var text : String = words.slice(1).reduce(join, words[0])
				spell_text.set_spell_text(text)

func clear_debuff(name: String) -> void:
	applied_debuffs.erase(name)
	match name:
		"STICKINESS":
			generate_movement_labels()

func update_state() -> void:
	var applied_debuffs_names := applied_debuffs.keys()
	var debuffs_to_apply : Array[String] = []
	for debuff : Dictionary in debuffs:
		var debuff_name : String = debuff["name"]
		if !applied_debuffs.has(debuff_name):
			debuffs_to_apply.append(debuff_name)
		else:
			var index := applied_debuffs_names.find(debuff_name)
			if index >= 0:
				applied_debuffs_names.remove_at(index)
	for debuff_name : String in debuffs_to_apply:
		applied_debuffs[debuff_name] = true
	for debuff_name : String in debuffs_to_apply:
		apply_debuff(debuff_name)
	for debuff_name : String in applied_debuffs_names:
		clear_debuff(debuff_name)

func check_debuff(name: String) -> bool:
	for d : Dictionary in debuffs:
		if d["name"] == name:
			return true
	return false

func check_buff(name: String) -> bool:
	for b: Dictionary in buffs:
		if b["name"] == name:
			return true
	return false

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

func enter_targeting_state(spell: Spell) -> void:
	if spell == null:
		return
	if spell.description.require_target:
		state = State.Targeting
		chosen_spell = spell.description
		hide_player_arrows.emit()
		SymbolGeneration.clear()
		labeled_enemies.clear()
		label_visible_enemies()
	else:
		state = State.Casting
		chosen_spell = spell.description
		hide_player_arrows.emit()
		SymbolGeneration.clear()
		labeled_enemies.clear()
		SocketClient.cast_start_spell_on_self(chosen_spell.spell_id)
		var spell_word_count := spell_difficulty_word_count(chosen_spell.difficulty)
		var words := generate_words(spell_word_count)
		var text : String = words.slice(1).reduce(join, words[0])
		enter_casting_state(text)

func spell_difficulty_word_count(difficulty: String) -> int:
	match difficulty:
		"LOW":
			return 3
		"MIDDLE":
			return 4
		"HIGH":
			return 5
		_:
			return 3

func pick_enemy(str: String) -> void:
	if labeled_enemies.has(str):
		for enemy_key : String in labeled_enemies:
			var enemy : Enemy  = labeled_enemies[enemy_key]
			enemy.hide_target_label()
		target_enemy = labeled_enemies[str]
		labeled_enemies.clear()
		SocketClient.cast_start_spell(chosen_spell.spell_id, target_enemy.id)
		var spell_word_count := spell_difficulty_word_count(chosen_spell.difficulty)
		var words := generate_words(spell_word_count)
		var text : String = words.slice(1).reduce(join, words[0])
		enter_casting_state(text)

func join(accum: String, word: String) -> String:
	return accum + " " + word

func enter_casting_state(text: String) -> void:
	state = State.Casting
	spell_text.set_spell_text(text)
	casting_panel.show()

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT,
	NULL
}

var succeded_arrow : Direction = Direction.NULL

func move(text: String) -> void:
	var symbol_count := 1
	if check_debuff("STICKINESS"):
		symbol_count += 1
	entered_movement_text += text
	if up_key.begins_with(entered_movement_text):
		if up_key == entered_movement_text:
			move_player_up.emit()
			entered_movement_text = ""
			succeded_arrow = Direction.NULL
			generate_movement_labels()
		else:
			player_controller.register_char_up_arrow(text)
			succeded_arrow = Direction.UP
		return
	elif succeded_arrow == Direction.UP:
		player_controller.clear_up_arrow_state()

	if down_key.begins_with(entered_movement_text):
		if down_key == entered_movement_text:
			move_player_down.emit()
			entered_movement_text = ""
			succeded_arrow = Direction.NULL
			generate_movement_labels()
		else:
			player_controller.register_char_down_arrow(text)
			succeded_arrow = Direction.DOWN
		return
	elif succeded_arrow == Direction.DOWN:
		player_controller.clear_down_arrow_state()

	if left_key.begins_with(entered_movement_text):
		if left_key == entered_movement_text:
			move_player_left.emit()
			entered_movement_text = ""
			succeded_arrow = Direction.NULL
			generate_movement_labels()
		else:
			player_controller.register_char_left_arrow(text)
			succeded_arrow = Direction.LEFT
		return
	elif succeded_arrow == Direction.LEFT:
		player_controller.clear_left_arrow_state()

	if right_key.begins_with(entered_movement_text):
		if right_key == entered_movement_text:
			move_player_right.emit()
			entered_movement_text = ""
			succeded_arrow = Direction.NULL
			generate_movement_labels()
		else:
			player_controller.register_char_right_arrow(text)
			succeded_arrow = Direction.RIGHT
		return
	elif succeded_arrow == Direction.RIGHT:
		player_controller.clear_right_arrow_state()

	entered_movement_text = ""

func generate_movement_labels() -> void:
	SymbolGeneration.clear()
	entered_movement_text = ""
	var symbol_count := 1
	if check_debuff("STICKINESS"):
		symbol_count += 1
	up_key = SymbolGeneration.generate_symbol(symbol_count)
	down_key = SymbolGeneration.generate_symbol(symbol_count)
	left_key = SymbolGeneration.generate_symbol(symbol_count)
	right_key = SymbolGeneration.generate_symbol(symbol_count)
	player_controller.set_arrows_label(up_key, down_key, left_key, right_key)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match state:
			State.Normal:
				if event.keycode >= KEY_0 and event.keycode <= KEY_9:
					if event.keycode == KEY_0:
						enter_targeting_state(spell_list_panel.get_spell(9))
					else:
						enter_targeting_state(spell_list_panel.get_spell(event.keycode - 48 - 1))
				else:
					move(String.chr(event.keycode).to_lower())
			State.Casting:
				if event.keycode == KEY_BACKSPACE:
					spell_text.delete_character()
				elif event.keycode == KEY_ESCAPE:
					casting_panel.hide()
					state = State.Normal
					get_viewport().set_input_as_handled()
				else:
					spell_text.register_character(String.chr(event.unicode))
			State.Targeting:
				pick_enemy(String.chr(event.unicode).to_lower())

func set_hp(value: int) -> void:
	if healthbar.value > value:
		player_controller.play_taken_damage_animation()
	healthbar.value = value

func _on_spell_text__on_spell_casted() -> void:
	if state == State.Casting:
		casting_panel.hide()
		state = State.Normal
		show_player_arrows.emit()
		if chosen_spell.require_target:
			SocketClient.cast_end_spell(chosen_spell.spell_id, target_enemy.id)
		else:
			SocketClient.cast_end_spell_on_self(chosen_spell.spell_id)
		target_enemy = null
		# TODO: Send end cast
