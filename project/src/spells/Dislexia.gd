@tool
extends Spell

func _ready() -> void:
	super._ready()
	description = SpellDescription.new()
	description.difficulty = "MIDDLE"
	description.spell_id = "DYSLEXIA"
	description.spell_name = "Dislexia"
