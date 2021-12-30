extends Control

export (float) var tweenDistance = 0

onready var background: = $"../BackgroundBlur"
onready var startMenu: = $"../StartMenu"

func _on_TextureButton_pressed()->void:
	background.blurBackground()
	get_tree().call_group('MainMenu', '_button_hide')
	startMenu.openMenu()
