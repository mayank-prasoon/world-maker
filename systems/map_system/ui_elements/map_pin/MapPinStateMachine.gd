extends StateMachine

var mouse_inside:bool = false
var clicked:bool      = false
var dragged           = false

# === NODES ===

# animation
onready var hover_animation:AnimationPlayer        = $"../AnimationTree/HoverAnimation"
onready var progress_bar_animation:AnimationPlayer = $"../AnimationTree/ProgressBarProgress"
onready var drag_animation:AnimationPlayer         = $"../AnimationTree/DragAnimation"

onready var timer:Timer                            = $"../Timer"

enum STATE {
	NULL,
	HOVER,
	CLICK,
	DRAG
}


func _ready():
	current_state = STATE.NULL


func _process(_delta:float)->void:
	var new_state = _state_transition()
	if new_state != current_state && new_state != null:
		_change_state(new_state)
	_state_logic()                # always keeep at he buttom


# run the logic
func _state_logic() -> void:
	mouse_interaction()

# ------------------------------------------------------------------------------

# change state
func _state_transition() -> int:
	if !get_parent().disabled:
		match current_state:
			STATE.NULL:
				if mouse_inside:
					return STATE.HOVER
				elif clicked:
					return STATE.CLICK
				else:
					return current_state

			STATE.HOVER:
				if !mouse_inside:
					return STATE.NULL
				elif clicked:
					return STATE.CLICK
				else:
					return current_state

			STATE.CLICK:
				if dragged:
					return STATE.DRAG
				elif !clicked:
					return STATE.HOVER
				else:
					return current_state

			STATE.DRAG:
				if !dragged:
					return STATE.HOVER
				else:
					return current_state
			_:
				return current_state
	else:
		return current_state


func mouse_interaction() -> void:
	if [STATE.NULL].has(current_state):
		pass

	if [STATE.HOVER].has(current_state):
		pass

	if (STATE.DRAG == current_state):
		if dragged == true:
			var position = get_parent().get_global_mouse_position()

			get_parent().pin_resource.pin_location = position
			get_parent().position                  = position

# ------------------------------------------------------------------------------

# called when entered a state
func _enter_state(new_state, old_state)->void:
	match new_state:
		STATE.CLICK:
			timer.start()
			EventBus.emit_signal("move_pin_to_top", get_parent())

			# animation
			progress_bar_animation.play("progress_bar")


		STATE.HOVER:
			# animation
			if [STATE.NULL, STATE.DRAG].has(old_state):
				hover_animation.play("mouse_hover")


		STATE.DRAG:
			# animation
			hover_animation.play_backwards("mouse_hover")
			drag_animation.play("dragged")
			progress_bar_animation.play("RESET")

			#siganl
			EventBus.emit_signal("close_article_panel")
			EventBus.emit_signal("change_inspector_state", false)

# ------------------------------------------------------------------------------

# called when exiciting a state
func _exit_state(old_state, new_state) -> void:
	match old_state:
		STATE.DRAG:
			dragged = false
			timer.stop()
			timer.set_wait_time(1)
			get_parent().save_pin()

			# animation
			drag_animation.play_backwards("dragged")


		STATE.HOVER:
			if new_state == STATE.NULL:
				# animation
				hover_animation.play_backwards("mouse_hover")


		STATE.CLICK:
			if (new_state != STATE.DRAG):
				# animation
				progress_bar_animation.play_backwards("progress_bar")

# ------------------------------------------------------------------------------

func _on_Area2D_input_event(_viewport, event, _shape_idx)->void:
	var sprite:AnimatedSprite = $"../Sprite"

	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			clicked = true
			get_tree().set_input_as_handled()

		elif !event.is_pressed() and event.button_index == BUTTON_LEFT:
			reset_drag()

	if event is InputEventMouseMotion:
		sprite.play("hover")


func _on_Timer_timeout():
	dragged      = true


func _on_Area2D_mouse_entered():
	mouse_inside = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_Area2D_mouse_exited():
	mouse_inside = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	
	if !dragged:
		reset_drag()


func reset_drag():
	clicked      = false
	dragged      = false

	timer.stop()
	timer.wait_time = 1
