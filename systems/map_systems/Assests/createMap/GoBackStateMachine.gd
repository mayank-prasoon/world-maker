extends StateMachine

enum BUTTON_STATE {
	DISABLED,
	ENABLED
}

func _ready() -> void:
	if SystemMapData.mapTexture.size() == 0:
		get_parent().playAnimation()

	_current_state = BUTTON_STATE.ENABLED
	_previou_state = BUTTON_STATE.DISABLED


func _process(_delta) -> void:
	var _new_state = _state_transition()
	if _new_state != _current_state && _new_state != null:
		_change_state(_new_state)
	_state_logic()         #always keep at he bottom


func _state_logic() -> void :
	_hangle_button()


func _hangle_button()->void:
	if BUTTON_STATE.ENABLED == _current_state:
		if SystemMapData.mapName.size() == 0:
			if SystemMapData.mapTexture.size() == 0:
				_current_state = BUTTON_STATE.DISABLED

	if BUTTON_STATE.DISABLED == _current_state:
		if SystemMapData.mapName.size() != 0 || SystemMapData.mapTexture.size() != 0:
			_current_state = BUTTON_STATE.ENABLED


func _state_transition():
	match _current_state:
		BUTTON_STATE.ENABLED:
			$"../Button".disabled = false
		BUTTON_STATE.DISABLED:
			$"../Button".disabled = true


func _enter_state(_new_state:int, _old_state:int)->void:
	pass

func _exit_state(_old_state:int, _new_state:int)->void:
	pass


