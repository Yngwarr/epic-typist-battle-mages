@tool
extends Spell

func _ready() -> void:
	super._ready()
	description = SpellDescription.new()
	description.difficulty = "MIDDLE"
	description.spell_id = "EXPLOSION"
	description.spell_name = "Explosion"
	description.require_target = false
