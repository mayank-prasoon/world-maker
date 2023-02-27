extends Panel

signal mouse_pointer_entered
signal mouse_pointer_exited

var mouse_enter:bool  = true

var mouse_inside:bool = true


func if_inside_rect()->bool:
	var is_inside = false

	if get_global_mouse_position().x >= self.global_position.x:
		if get_global_mouse_position().x <= self.size.x + self.global_position.x:
			if get_global_mouse_position().y >= self.global_position.y:
				if get_global_mouse_position().y <= self.size.y + self.global_position.y:
					is_inside = true

	return is_inside

# mouse enter and exit system
func check_mouse_enter()->void:
	if if_inside_rect():
		if mouse_enter != true:
			mouse_enter = true
			emit_signal("mouse_pointer_entered")

	if !if_inside_rect():
		if mouse_enter != false:
			mouse_enter = false
			emit_signal("mouse_pointer_exited")



var tally:int = 0

func _on_Background_mouse_pointer_entered()->void:
#	$AnimationPlayer.play("hover")
#	tally = 1
	pass

func _on_Background_mouse_pointer_exited()->void:
#	if tally == 1:
#		$AnimationPlayer.play_backwards("hover")
	pass

func _process(_delta:float)->void:
	check_mouse_enter()



func _on_Background_focus_entered()->void:
	$FocusAnimation.play("focused")


func _on_Background_focus_exited()->void:
	$FocusAnimation.play_backwards("focused")
