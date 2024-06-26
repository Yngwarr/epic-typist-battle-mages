class_name Game
extends Node2D

## The game node, the beginning of all, the almighty entry point, the place,
## where your dreams come true! Adjust to your likings and may the code be with
## you.

@onready var hud : HUD = $HUD

@export var pause_ctl: Pause
@export var pause_menu: PauseMenu
@export var game_over_screen: GameOverScreen

@export var self_player: PlayerController
@export var enemy_scene: PackedScene
@export var player_container: TileMap

@export var arena_border: ArenaBorder

var players: Dictionary = {}

var casting_players := []

func _ready() -> void:
	pause_menu.modal_open.connect(pause_ctl.drop_next)
	pause_menu.resume_pressed.connect(pause_ctl.unpause)
	hud.generate_movement_labels()
	SocketClient.new_state.connect(update_state)
	SocketClient.got_id.connect(on_got_id)
	SocketClient.enter_server()

# TODO do something with the disconnected players, check Lobby for reference
func update_state(state: Variant) -> void:
	var game_status: String = state["status"]

	# assert(game_status == Global.StatePreparation, "game can't go from InProgress straight to Preparation")

	if game_status == Global.StateGameOver:
		game_over_screen.appear(state["winner"])
		return

	for p: Dictionary in state["players"]:
		var id: String = p["id"]
		var x: int = p["x"]
		var y: int = p["y"]
		var hp: int = p["hp"]
		var alive: bool = p["alive"]
		var local_pos := player_container.map_to_local(Vector2i(x, y))

		if id == Global.self_id:
			self_player.position.x = local_pos.x
			self_player.position.y = local_pos.y
			hud.debuffs = p["debuffs"]
			hud.buffs = p["buffs"]
			hud.update_state()
			hud.set_hp(hp)
			if !alive:
				self_player.die()
			continue

		if not players.has(id):
			var new_player: Enemy = enemy_scene.instantiate()
			var player_name: String = p["name"]
			new_player.id = id
			new_player.position.x = local_pos.x
			new_player.position.y = local_pos.y
			new_player.player_name = player_name
			new_player.set_hp(hp)
			
			players[id] = new_player
			player_container.add_child(new_player)
			new_player.on_screen_enter.connect(_on_visible_player_screen_enter)
			new_player.on_screen_exited.connect(_on_visible_player_screen_exited)
			continue

		var player: Enemy = players[id]
		player.position.x = local_pos.x
		player.position.y = local_pos.y
		player.set_hp(hp)
		if !alive:
			player.die()

	var currently_casting_players : Array = state["spellsInProgress"]
	var players_to_cast_end_animation := casting_players
	var new_casting_players := []
	for p : Dictionary in currently_casting_players:
		var player_id : String = p["playerFromId"]
		if player_id != Global.self_id and players.has(player_id):
			var player : Enemy = players[player_id]
			player.play_cast_animation()
			var index := players_to_cast_end_animation.find(player_id)
			if index != -1:
				players_to_cast_end_animation.remove_at(index)
			new_casting_players.append(player_id)
	
	for id : String in players_to_cast_end_animation:
		var player : Enemy = players[id]
		player.play_cast_end_animation()
		
	casting_players = new_casting_players
	
	var arena: Dictionary = state["arena"]
	arena_border.resize(Vector2i(arena["centerX"], arena["centerY"]), arena["lifeRadius"], arena["originalSize"])

func on_got_id(new_id: String) -> void:
	pass

func _on_visible_player_screen_enter(enemy: Enemy) -> void:
	hud.add_visible_enemy(enemy)

func _on_visible_player_screen_exited(enemy: Enemy) -> void:
	hud.remove_visible_enemy(enemy)

func _on_hud_move_player_up() -> void:
	self_player.move(Vector2.UP)

func _on_hud_move_player_right() -> void:
	self_player.move(Vector2.RIGHT)

func _on_hud_move_player_down() -> void:
	self_player.move(Vector2.DOWN)

func _on_hud_move_player_left() -> void:
	self_player.move(Vector2.LEFT)

func _on_hud_set_players_arrows(up: String, down: String, left: String, right: String) -> void:
	self_player.set_arrows_label(up, down, left, right)

func _on_hud_hide_player_arrows() -> void:
	self_player.hide_arrows()

func _on_hud_show_player_arrows() -> void:
	self_player.show_arrows()
