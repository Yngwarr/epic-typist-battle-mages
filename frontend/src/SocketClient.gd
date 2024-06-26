extends Node

signal message_received(message: String)

var socket = WebSocketPeer.new()

func _ready() -> void:
	socket.connect_to_url("ws://localhost:9092")

func _process(_delta: float) -> void:
	socket.poll()
	var state := socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var packet := socket.get_packet()
			print("Packet: ", packet)
			message_received.emit(packet.get_string_from_utf8())
	elif state == WebSocketPeer.STATE_CLOSING:
		# Keep polling to achieve proper close.
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code = socket.get_close_code()
		var reason = socket.get_close_reason()
		print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		set_process(false) # Stop processing.

func send(message: String) -> void:
	socket.send_text(message)
