extends Node

enum CellType {
	ACTOR,
	OBSTACLE,
	OBJECT,
}

var self_id: String

func direction_name(direction: Vector2i) -> String:
	match direction:
		Vector2i.UP: return "up"
		Vector2i.DOWN: return "down"
		Vector2i.LEFT: return "left"
		Vector2i.RIGHT: return "right"
		_: return "PANIC"
