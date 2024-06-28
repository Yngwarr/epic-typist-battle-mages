@tool
extends Spell

func _ready() -> void:
	super._ready()
	description = SpellDescription.new()
	description.difficulty = "MIDDLE"
	description.spell_id = "CONCENTRATION"
	description.spell_name = "Concentration"
	description.require_target = false
