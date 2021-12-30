extends StateMachine

enum BUTTON_MODE {
	EDIT,
	NEW
}

func _ready() -> void:
	_current_state = BUTTON_MODE.EDIT
	_previou_state = BUTTON_MODE.NEW


func _process(_delta) -> void:
	var _new_state = _state_transition()
	if _new_state != _current_state && _new_state != null:
		_change_state(_new_state)
	_state_logic()         #always keep at he bottom


func _state_logic() -> void :
	_hangle_button_name()

func _state_transition():
	match _current_state:
		BUTTON_MODE.NEW:
			if !get_parent().isStateNew:
				_current_state = BUTTON_MODE.EDIT
			else:
				pass
		BUTTON_MODE.EDIT:
			if get_parent().isStateNew:
				_current_state = BUTTON_MODE.NEW

func _hangle_button_name()->void:
	#var speed = get_parent().motion.x * _direction 
	var button:Button = $"../Button"
	match _current_state:
		BUTTON_MODE.NEW:
			button.text = 'new'
		BUTTON_MODE.EDIT:
			button.text = 'edit'


func _enter_state(_new_state:int, _old_state:int)->void:
	pass

func _exit_state(_old_state:int, _new_state:int)->void:
	pass
