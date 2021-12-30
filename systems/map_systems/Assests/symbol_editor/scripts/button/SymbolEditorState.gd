extends StateMachine

onready var symbol:Node = $"../SymbolData"

enum BUTTON_STATE {
	DISABLED,
	ENABLED
}

func _ready() -> void:
	_current_state = BUTTON_STATE.DISABLED
	_previou_state = BUTTON_STATE.ENABLED


func _process(_delta) -> void:
	var _new_state = _state_transition()
	if _new_state != _current_state && _new_state != null:
		_change_state(_new_state)
	_state_logic()                                           #always keep at he bottom


func _state_logic() -> void :
	_hangle_button()

func _state_transition():
	match _current_state:
		BUTTON_STATE.ENABLED:
			if symbol.isFieldEmpty():
				return BUTTON_STATE.DISABLED

		BUTTON_STATE.DISABLED:
			if !symbol.isFieldEmpty():
				return BUTTON_STATE.ENABLED

func _hangle_button()->void:
	match _current_state:
		BUTTON_STATE.ENABLED:
			$"../Button".disabled = false
		BUTTON_STATE.DISABLED:
			$"../Button".disabled = true



func _enter_state(_new_state:int, _old_state:int)->void:
	pass


func _exit_state(_old_state:int, _new_state:int)->void:
	pass
