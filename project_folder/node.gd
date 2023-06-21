extends Node2D

enum {
	CHARACTER,
	BLOCK
} 

var cur_state:int = self.CHARACTER
var pre_state:int = self.BLOCK

# --------------------------------------------------------------------------------------------------

func _input(event:InputEvent)->void:
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_SPACE:
			change_state(
				BLOCK if cur_state == CHARACTER else CHARACTER,
				BLOCK if pre_state == CHARACTER else CHARACTER
			)

# --------------------------------------------------------------------------------------------------

# state entered
func _state_entered(new, old)->void:
	if new == self.CHARACTER:
		for x in self.get_children():
			x.queue_free()
		self.add_child(preload("res://CharacterBody2d.tscn").instantiate())
	else:
		for x in self.get_children():
			x.queue_free()
	
	cur_state = new as int
	pre_state = old as int

# --------------------------------------------------------------------------------------------------

# change state
func change_state(new:int, old:int)->void:
	var undo_redo:UndoRedo = GlobalUndoRedo.undo_redo
	undo_redo.create_action('changed state')
	undo_redo.add_do_property(self, 'cur_state', new)
	undo_redo.add_undo_property(self, 'cur_state', old)
	undo_redo.commit_action()

