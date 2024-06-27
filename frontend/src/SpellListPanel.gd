extends Panel


@onready var slow_debuff := $HBoxContainer/Stickiness
@onready var magic_missile := $HBoxContainer/MagicMissile
@onready var confusion := $HBoxContainer/Confusion
@onready var fireball := $HBoxContainer/Fireball
@onready var explosion := $HBoxContainer/Explosion

@onready var spells : Array[Spell] = [
	magic_missile,
	slow_debuff,
	confusion,
	fireball,
	explosion
]

func get_spell(index: int) -> Spell:
	if index > spells.size():
		return null
	return spells[index]
