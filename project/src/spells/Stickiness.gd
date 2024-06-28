@tool
extends Spell

func _ready() -> void:
	super._ready()
	description = SpellDescription.new()
	description.difficulty = "Low"
	description.spell_id = "STICKINESS"
	description.spell_name = "Slow debuff"
