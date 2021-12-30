extends Control

onready var UIAnimation: = $"UIAnimation/AnimationPlayer"

func _ready()->void:
	add_to_group('MainMenu')

func _reset_button()->void:
	UIAnimation.play("StartMenu_animation")

func _button_hide()->void:
	UIAnimation.play_backwards("StartMenu_animation")

