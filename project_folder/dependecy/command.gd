class_name Command
extends RefCounted

var undo_redo:UndoRedo      = GlobalUndoRedo.undo_redo
var action_name:String      = ''

# list of action
var do_command_list:Dictionary   = {}
var undo_command_list:Dictionary = {}

# ------------------------------------------------------------------------------

func _init()->void:
	pass

# ------------------------------------------------------------------------------

func exicute_command()->void:
	pass

# ------------------------------------------------------------------------------

# append do command list
func _append_do_command_list(index, action:Callable)->void:
	do_command_list[index] = action

# ------------------------------------------------------------------------------

# append undo command list
func _append_undo_command_list(index, action:Callable)->void:
	undo_command_list[index] = action
