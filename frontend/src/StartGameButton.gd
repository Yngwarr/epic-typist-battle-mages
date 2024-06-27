class_name StartGameButton
extends Button

@export_file("*.tscn") var next_scene_name: String

func _ready() -> void:
    pressed.connect(on_pressed)

func on_pressed() -> void:
    SocketClient.start_game()
