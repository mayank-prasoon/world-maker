extends Control

onready var animationPlayer: = $AnimationPlayer
onready var popButton:       = $PopUpMenuContainer/Open/OpenClose2

var currentStat:bool = false 

func _on_OpenClose_pressed() -> void:
	popButton.focus_mode = Control.FOCUS_NONE
	if !currentStat:
		animationPlayer.play("popup")
		currentStat = true
	else:
		animationPlayer.play_backwards("popup")
		currentStat = false
