extends Node

# signal command_changed(command: String)
#
# var _command: String = ''
# var command: String:
# 	get: return _command
# 	set(value):
# 		if value == _command: return
# 		_command = value
# 		command_changed.emit(_command)
#
# func _input(event: InputEvent) -> void:
# 	if event is InputEventKey and event.pressed:
# 		cmd_input(event)
#
# func cmd_input(event: InputEventKey) -> void:
# 	var keycode := event.keycode
#
# 	if event.ctrl_pressed:
# 		match keycode:
# 			KEY_U:
# 				command = ''
# 			KEY_W:
# 				var space_index := command.substr(0, len(command) - 1).rfind(' ')
# 				command = '' if space_index < 0 else command.substr(0, space_index + 1)
# 	else:
# 		match keycode:
# 			KEY_ENTER:
# 				send_command()
# 			KEY_BACKSPACE:
# 				command = command.left(-1)
# 			_:
# 				if len(command) == CMD_MAX_LEN: return
# 				var ch := key_to_char(keycode)
# 				if len(ch) > 0:
# 					command += ch
#
# func send_command() -> void:
# 	if len(command) == 0: return
#
# 	command_dispatcher.process_command(command)
# 	history.erase(command)
# 	history.push_back(command)
# 	if len(history) > HISTORY_SIZE:
# 		history.pop_front()
#
# 	# reset the command
# 	hist_pos = len(history)
# 	command = ''
