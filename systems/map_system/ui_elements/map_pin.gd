extends Node2D


func _on_Area2D_mouse_entered():
	$AnimationPlayer.play("mouse_hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Area2D_mouse_exited():
	$AnimationPlayer.play_backwards("mouse_hover")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
