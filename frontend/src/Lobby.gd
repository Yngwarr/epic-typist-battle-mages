class_name Lobby
extends Node2D

@export var label_container: BoxContainer
@export var player_count: Label
@export_file("*.tscn") var next_scene_name: String

var labels: Dictionary = {}

func _ready() -> void:
	SocketClient.new_state.connect(update_list)
	SocketClient.enter_server()

func update_list(state: Variant) -> void:
	var current_ids := labels.keys()

	if state["status"] == Global.StateInProgress:
		get_tree().change_scene_to_file(next_scene_name)
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
