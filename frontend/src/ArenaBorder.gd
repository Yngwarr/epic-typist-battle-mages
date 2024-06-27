class_name ArenaBorder
extends TileMap

func resize(center: Vector2i, radius: int, original_radius: int) -> void:
	# print("center ", center, " orig ", original_radius, " radius ", radius)
	for x in range(original_radius):
		for y in range(original_radius):
			if x < center.x - radius or x > center.x + radius \
				or y < center.y - radius or y > center.y + radius:
				set_cell(0, Vector2i(x, y), 0, Vector2i(0, 0))
			else:
				erase_cell(0, Vector2i(x, y))
