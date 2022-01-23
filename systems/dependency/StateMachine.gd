class_name StateMachine
extends Node

signal state_change(old_state, new_state)

var _current_state:int
var _previou_state:int


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


func _change_state(_new_state):
	_previou_state = _current_state
	_current_state = _new_state
	_enter_state(_new_state, _previou_state)
	_exit_state(_previou_state, _new_state)

	emit_signal("state_change", _previou_state, _new_state)
