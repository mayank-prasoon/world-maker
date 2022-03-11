extends Control

#show the inspector
export var show_inspector:bool = false

var dragged_node

func _ready():
	pass


func _on_Button_pressed()->void:
	show_inspector = !show_inspector

	if show_inspector: # close the inspector
		inspector_slide_animation(
				Vector2(300, 0),
				Vector2(0, 0)
		)

	else: # open the inspector
		inspector_slide_animation(
				Vector2(0, 0),
				Vector2(300, 0)
		)


# play the open/close animation of the inspector
func inspector_slide_animation(init_pos, final_pos)->void:
	$Tween.interpolate_property(
		get_child(0),
		"rect_position",
		init_pos,
		final_pos,
		0.5,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN_OUT
	)
	
	$Tween.start()
