@tool
extends Spell

func _ready() -> void:
	super._ready()
	description = SpellDescription.new()
	description.difficulty = "Low"
	description.spell_id = "CONFUSION"
	description.spell_name = "Confusion"
