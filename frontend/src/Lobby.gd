class_name Lobby
extends Node2D

@export var label_container: BoxContainer
@export var player_count: Label
@export_file("*.tscn") var next_scene_name: String
@export var status_label: Label
@export var start_button: Button

var labels: Dictionary = {}

func _ready() -> void:
	SocketClient.new_state.connect(update_list)
	SocketClient.enter_server()

	if OS.has_feature("standalone"):
		start_button.visible = false


func update_list(state: Variant) -> void:
	var current_ids := labels.keys()

	status_label.text = status_text(state["status"])

	if state["status"] == Global.StateInProgress:
		get_tree().change_scene_to_file(next_scene_name)
		return

	if state["status"] == Global.StateGameOver:
		return

	player_count.text = str(len(state["players"]))

	for p: Dictionary in state["players"]:
		var id: String = p["id"]
		current_ids.erase(id)

		if not labels.has(id):
			var new_label := RichTextLabel.new()
			new_label.fit_content = true
			new_label.append_text(p["name"])

			if id == Global.self_id:
				new_label.append_text(" ")
				new_label.push_color(Color.GREEN)
				new_label.append_text("It's you!")
				new_label.pop_all()

			labels[id] = new_label
			label_container.add_child(new_label)
			continue

	for id: String in current_ids:
		labels[id].queue_free()
		labels.erase(id)

func status_text(state: String) -> String:
	match state:
		Global.StateGameOver: return "Please, wait for the game to end."
		Global.StatePreparation: return "Waiting for players."
		_: return "Game in progress."
