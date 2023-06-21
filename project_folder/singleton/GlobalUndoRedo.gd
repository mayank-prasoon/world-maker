extends Node

# undo redo object
var undo_redo:UndoRedo = UndoRedo.new()

# --------------------------------------------------------------------------------------------------

func _unhandled_input(event:InputEvent)->void:
	if event is InputEventWithModifiers:
		if event.is_pressed() and event.is_ctrl_pressed():
			if event.keycode == KEY_Z:
				undo_redo.undo()
			elif event.keycode == KEY_Y:
				undo_redo.redo()
 
# --------------------------------------------------------------------------------------------------

# registor the commands
func _registor_do(command:Command)->void:
	undo_redo.create_action(command.action_name)
	
	var add_to_do = func(callable): undo_redo.add_do_method(callable)
	var add_to_undo = func(callable): undo_redo.add_undo_method(callable)

# --------------------------------------------------------------------------------------------------

# commit the command stack
func commit_command_stack()->void:
	undo_redo.commit_action()
