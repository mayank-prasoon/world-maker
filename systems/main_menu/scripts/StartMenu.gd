extends Control

onready var background: = $"../BackgroundBlur"
onready var animation: = $"UiAnimaiton/AnimationPlayer"
onready var moveBack: = $"MoveBack/Button"

func _ready()->void:
	self.visible = false


func _on_Button_pressed()->void:  #close self
	background.unBlurBackground()
	get_tree().call_group('MainMenu', '_reset_button')
	hideMenu()

func openMenu()->void:            #visible self
	animation.play("StartMenu_animation")

func hideMenu()->void:            #hide self
	animation.play_backwards("StartMenu_animation")
