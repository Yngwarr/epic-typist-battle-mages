extends PanelContainer

signal _on_spell_casted()

@onready var spell_text_label : RichTextLabel = $MarginContainer/SpellText

var spell_text : String = "hello aaa"
var entered_text : String

func _ready() -> void:
	set_spell_text(spell_text)

func set_spell_text(text: String) -> void:
	spell_text = text
	spell_text_label.text = wrap_with_center(text)
	entered_text = ""

func find_first_invalid_character(base: String, other: String) -> int:
	for i in min(base.length(), other.length()) as int:
		if base[i] != other[i]:
			return i
	return -1

func wrap_with_center(str: String) -> String:
	return "[center]" + str + "[/center]"

func wrap_with_correct(str: String) -> String:
	return "[color=green][u]" + str + "[/u][/color]"

func wrap_with_incorrect(str: String) -> String:
	return "[color=red][u]" + str + "[/u][/color]"

func compare_words() -> void:
	var invalid_index := find_first_invalid_character(spell_text, entered_text)
	spell_text_label.text = ""
	spell_text_label.clear()
	var entered_text_length := entered_text.length()
	var styled_string := ""
	if invalid_index == -1:
		styled_string = wrap_with_correct(entered_text)
		styled_string += spell_text.substr(entered_text_length)
		styled_string = wrap_with_center(styled_string)
		spell_text_label.append_text(styled_string)
		if spell_text.length() == entered_text_length:
			_on_spell_casted.emit()
	else:
		styled_string = wrap_with_correct(entered_text.substr(0, invalid_index))
		styled_string += wrap_with_incorrect(spell_text.substr(invalid_index, entered_text_length - invalid_index))
		styled_string += spell_text.substr(entered_text_length)
		styled_string = wrap_with_center(styled_string)
		spell_text_label.append_text(styled_string)

func register_character(char: String) -> void:
	entered_text += char
	compare_words()

func delete_character() -> void:
	entered_text = entered_text.substr(0, max(entered_text.length() - 1, 0))
	compare_words()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_BACKSPACE:
			delete_character()
		else:
			register_character(String.chr(event.unicode))
	
