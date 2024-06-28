class_name GameOverScreen
extends CanvasLayer

@export var title: Label
@export var flavor: Label

func _ready() -> void:
	pass

func appear(winner: Dictionary) -> void:
	if winner["id"] == Global.self_id:
		title.text = "You win!"
		flavor.text = "You have fulfiled the prophecy and became THE LEGENDARY TYPIST!"
	else:
		title.text = "You died"
		flavor.text = "%s have fulfiled the prophecy! Sadly, it wasn't you." % winner["name"]
	visible = true
