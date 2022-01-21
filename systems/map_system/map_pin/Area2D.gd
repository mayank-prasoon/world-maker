extends Area2D

signal hover_over
signal hover_out

onready var location: = $"../Sprite"
onready var animation: = $"../AnimationPlayer"
onready var desiredScale:Vector2 = location.scale

func _physics_process(_delta: float) -> void:
	location.scale = lerp(location.scale, desiredScale, 0.2)

func _on_Area2D_mouse_entered() -> void:
	desiredScale = Vector2(2, 2)
	emit_signal("hover_over")
	animation.play("shadow")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	

func _on_Area2D_mouse_exited() -> void:
	desiredScale = Vector2(1.5, 1.5)
	emit_signal("hover_out")
	animation.play_backwards("shadow")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	
