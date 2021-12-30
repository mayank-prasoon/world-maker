extends Control

var currentTab:int = 0
var animationPlayed

func _on_Left_pressed() -> void:
	match currentTab:
		1:
			get_parent().ANIMATION_PLAYER.play_backwards("newIcon")
			currentTab -= 1
		2:
			get_parent().ANIMATION_PLAYER.play_backwards("descriptionOfIcon")
			currentTab -= 1

func _on_Right_pressed() -> void:
	match currentTab:
		0:
			get_parent().ANIMATION_PLAYER.play("newIcon")
			currentTab += 1
		1:
			get_parent().ANIMATION_PLAYER.play("descriptionOfIcon")
			currentTab += 1


func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	pass
