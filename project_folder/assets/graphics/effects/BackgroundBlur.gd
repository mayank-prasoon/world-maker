extends Control

@onready var animationPlayer: = $"AnimationPlayer" 

@export (bool) var Animate:bool = true

func _ready()->void:
	if Animate == true:
		animationPlayer.play("blur_background")
	if Animate == false:
		animationPlayer.play_backwards("blur_background")
	add_to_group('background')

func blurBackground()->void:
	animationPlayer.play("blur_background")

func unBlurBackground()->void:
	animationPlayer.play_backwards("blur_background")
