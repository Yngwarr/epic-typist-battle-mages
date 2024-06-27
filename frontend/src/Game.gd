class_name Game
extends Node2D

## The game node, the beginning of all, the almighty entry point, the place,
## where your dreams come true! Adjust to your likings and may the code be with
## you.

@onready var hud : HUD = $HUD

@export var pause_ctl: Pause
@export var pause_menu: PauseMenu
@export var game_over_screen: CanvasLayer

@export var self_player: PlayerController
@export var enemy_scene: PackedScene
@export var player_container: TileMap

@export var arena_border: ArenaBorder

var players: Dictionary = {}

func _ready() -> void:
	pause_menu.modal_open.connect(pause_ctl.drop_next)
	pause_menu.resume_pressed.connect(pause_ctl.unpause)
	hud.generate_movement_labels()
	SocketClient.new_state.connect(update_state)
	SocketClient.enter_server()

# TODO do something with the disconnected players, check Lobby for reference
func update_state(state: Variant) -> void:
	var game_status: String = state["status"]

	# assert(game_status == Global.StatePreparation, "game can't go from InProgress straight to Preparation")

	if game_status == Global.StateGameOver:
		game_over()
		return

	for p: Dictionary in state["players"]:
		var id: String = p["id"]
		var x: int = p["x"]
		var y: int = p["y"]
		var local_pos := player_container.map_to_local(Vector2i(x, y))

		if id == Global.self_id:
			self_player.position.x = local_pos.x
			self_player.position.y = local_pos.y
			continue

		if not players.has(id):
			var new_player: Enemy = enemy_scene.instantiate()
			new_player.id = id
			new_player.position.x = local_pos.x
			new_player.position.y = local_pos.y

			players[id] = new_player
			player_container.add_child(new_player)
			new_player.on_screen_enter.connect(_on_visible_player_screen_enter)
			new_player.on_screen_exited.connect(_on_visible_player_screen_exited)
			continue

		var player: Enemy = players[id]
		player.position.x = local_pos.x
		player.position.y = local_pos.y

	var arena: Dictionary = state["arena"]
	arena_border.resize(Vector2i(arena["centerX"], arena["centerY"]), arena["lifeRadius"], arena["originalSize"])

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

func game_over() -> void:
	game_over_screen.visible = true
