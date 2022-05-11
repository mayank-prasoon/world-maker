class_name StateMachine
extends Node

signal state_change(old_state, new_state)

var current_state:int
var previou_state:int


func _physics_process(_delta:float)->void:
	pass

func _state_logic()->void:
	pass

func _state_transition():
	pass

func _enter_state(_new_state, _old_state)->void:
	pass

func _exit_state(_old_state, _new_state)->void:
	pass


func _change_state(new_state):
	previou_state = current_state
	current_state = new_state
	_enter_state(new_state, previou_state)
	_exit_state(previou_state, new_state)

	emit_signal("state_change", previou_state, new_state)
