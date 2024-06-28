@tool
extends Spell


func _ready() -> void:
	super._ready()
	description = SpellDescription.new()
	description.difficulty = "Low"
	description.spell_id = "MAGIC_MISSILE"
	description.spell_name = "Magic missile"
