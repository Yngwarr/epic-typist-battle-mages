extends Panel


@onready var slow_debuff := $HBoxContainer/SlowDebuff

@onready var spells : Array[Spell] = [
	slow_debuff
]

func get_spell(index: int) -> Spell:
	if index > spells.size():
		return null
	return spells[index]
