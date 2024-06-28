class_name Enemy
extends Pawn

@onready var target : Sprite2D = $Target
@onready var target_label : Label = $TargetLabel
@onready var mage : Mage = $Mage

var id : String
var alive := true

signal on_screen_enter(enemy: Enemy)
signal on_screen_exited(enemy: Enemy)

func _ready() -> void:
	mage.set_skin(id)

func set_target(value: bool) -> void:
	target.visible = value

func set_target_label(text: String) -> void:
	target_label.text = text
	target_label.show()

func show_target_label() -> void:
	target_label.show()

func hide_target_label() -> void:
	target_label.text = ""
	target_label.hide()

func _on_visible_on_screen_notifier_screen_entered() -> void:
	on_screen_enter.emit(self)

func _on_visible_on_screen_notifier_screen_exited() -> void:
	on_screen_exited.emit(self)

func die() -> void:
	if alive:
		alive = false
		mage.die()
