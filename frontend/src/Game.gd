class_name Game
extends Node2D

## The game node, the beginning of all, the almighty entry point, the place,
## where your dreams come true! Adjust to your likings and may the code be with
## you.

@export var pause_ctl: Pause
@export var pause_menu: PauseMenu

@export var self_player: PlayerController
@export var enemy_scene: PackedScene
@export var player_container: TileMap

var players: Dictionary = {}

func _ready() -> void:
	pause_menu.modal_open.connect(pause_ctl.drop_next)
	pause_menu.resume_pressed.connect(pause_ctl.unpause)
	SocketClient.new_state.connect(update_state)

# TODO do something with the disconnected players, check Lobby for reference
func update_state(state: Variant) -> void:
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
			new_player.position.x = local_pos.x
			new_player.position.y = local_pos.y

			players[id] = new_player
			player_container.add_child(new_player)
			continue

		var player: Enemy = players[id]
		player.position.x = local_pos.x
		player.position.y = local_pos.y
