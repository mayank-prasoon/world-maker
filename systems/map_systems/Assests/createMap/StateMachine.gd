extends StateMachine

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
	_state_logic()         #always keep at he bottom


func _state_logic() -> void :
	_hangle_button()

func _state_transition():
	if BUTTON_STATE.ENABLED == _current_state:
		if get_parent().mapNameNode.text == '' or get_parent().mapTextureLocation == '':
				_current_state = BUTTON_STATE.DISABLED
	
	if BUTTON_STATE.DISABLED == _current_state:
		if get_parent().mapTextureLocation != '':
			if get_parent().mapNameNode.text != '':
				_current_state = BUTTON_STATE.ENABLED

func _hangle_button()->void:
#	var speed = get_parent().motion.x * _direction 
	match _current_state:
		BUTTON_STATE.ENABLED:
			$"../New".disabled = false
		BUTTON_STATE.DISABLED:
			$"../New".disabled = true


func _enter_state(_new_state:int, _old_state:int)->void:
	pass

func _exit_state(_old_state:int, _new_state:int)->void:
	pass


