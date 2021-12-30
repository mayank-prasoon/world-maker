extends Control

onready var animate: = $ProgressBar/Tween
onready var animation: = $AnimationPlayer

func _start() -> void:
	animate.interpolate_property(
		$ProgressBar,
		'value',
		0,
		100,
		1,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN_OUT
	)
	animate.start()


func _on_Tween_tween_all_completed() -> void:
	$AnimationPlayer.play("close")

func _on_MapEditor_image_loaded() -> void:
	_start()
