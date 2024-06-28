extends Node

signal new_state(state: Variant)
signal got_id(id: String)

# const backendURL: String = "http://localhost:9092/socket.io"
const backendURL: String = "http://192.168.1.111:9092/socket.io"
var client: SocketIOClient
var connected := false

func socket_connect() -> void:
	# initialize client
	client = SocketIOClient.new(backendURL)


	# this signal is emitted when the socket is ready to connect
	client.on_engine_connected.connect(on_socket_ready)

	# this signal is emitted when socketio server is connected
	client.on_connect.connect(on_socket_connect)

	# this signal is emitted when socketio server sends a message
	client.on_event.connect(on_socket_event)

	# add client to tree to start websocket
	add_child(client)

func _exit_tree() -> void:
	socket_disconnect()

func socket_disconnect() -> void:
	if connected:
		client.socketio_disconnect()

func on_socket_ready(_sid: String) -> void:
	# connect to socketio server when engine.io connection is ready
	print("on socket ready")
	client.socketio_connect()

func on_socket_connect(_payload: Variant, _name_space: Variant, error: bool) -> void:
	if error:
		push_error("Failed to connect to backend!")
		print("failed to connect socket")
	else:
		connected = true
		print("Socket connected")
		new_player(Tools.generate_name())

func on_socket_event(event_name: String, payload: Variant, _name_space: Variant) -> void:
	match event_name:
		"gameState":
			print(event_name, " ", payload)
			new_state.emit(payload)
		"newPlayer":
			print("newPlayer ", payload)
			Global.self_id = payload["id"]
			got_id.emit(Global.self_id)

	# respond hello world
	# client.socketio_send("hello", "world")

func enter_server() -> void:
	socket_connect()

func new_player(playerName: String) -> void:
	client.socketio_send("newPlayer", { "name": playerName })

func move(direction: Vector2i) -> void:
	client.socketio_send("move", {
		"playerId": Global.self_id,
		"command": "move",
		"direction": Global.direction_name(direction)
	})

func cast_start_spell(spell_name: String, target_id: String) -> void:
	client.socketio_send("spellCastStart", {
		"playerFromId": Global.self_id,
		"playerToId": target_id,
		"spellName": spell_name
	})

func cast_end_spell(spell_name: String, target_id: String) -> void:
	client.socketio_send("spellCastEnd", {
		"playerFromId": Global.self_id,
		"playerToId": target_id,
		"spellName": spell_name
	})

func cast_start_spell_on_self(spell_name: String) -> void:
	client.socketio_send("spellCastStart", {
		"playerFromId": Global.self_id,
		"spellName": spell_name
	})

func cast_end_spell_on_self(spell_name: String) -> void:
	client.socketio_send("spellCastEnd", {
		"playerFromId": Global.self_id,
		"spellName": spell_name
	})

func start_game() -> void:
	client.socketio_send("startGame", {})

func close_connection() -> void:
	if Global.self_id:
		client.socketio_send("close", {"id": Global.self_id})
