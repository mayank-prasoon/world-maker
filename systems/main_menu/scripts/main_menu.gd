extends Control


func new_project()->void:
	$NewProject.visible    = true
	$OpenProject.visible   = false
	$UIElement.visible     = false
	$WhatsNew.visible      = false

	$BackgroundBlur.blurBackground()
	$NewProject/AnimationPlayer.play("load")
	$UIElement/AnimationPlayer.play("RESET")
	

func reset_menu_ui()->void:
	$NewProject.visible    = false
	$OpenProject.visible   = false
	$UIElement.visible     = true
	$WhatsNew.visible      = false
	for x in $OpenProject/VBoxContainer.get_children():
		x.queue_free()

	$BackgroundBlur.unBlurBackground()
	$NewProject/AnimationPlayer.play("RESET")
	$OpenProject/AnimationPlayer.play("RESET")


func open_project()->void:
	Logger.info(name + " _on_OpenProjectButton_pressed()")
	$NewProject.visible    = false
	$OpenProject.visible   = true
	$UIElement.visible     = false
	$WhatsNew.visible      = false

	$OpenProject/AnimationPlayer.play("load")
	$UIElement/AnimationPlayer.play("RESET")

	$OpenProject.add_projects()
	$BackgroundBlur.blurBackground()


func _ready()->void:
	Logger.info(name + " - " + "node loaded")
	$NewProject.visible    = false
	$OpenProject.visible   = false
	$UIElement/VBoxContainer.visible = true


func _on_NewProjectButton_pressed()->void:
	new_project()


func _on_Button2_pressed()->void:
	reset_menu_ui()


func _on_OpenProjectButton_pressed()->void:
	open_project()


func _on_WhatsNewButton_pressed():
	$NewProject.visible    = false
	$OpenProject.visible   = false
	$UIElement.visible     = false
	$WhatsNew.visible      = true
	
	$BackgroundBlur.blurBackground()
	$WhatsNew/AnimationPlayer.play("load")
	$UIElement/AnimationPlayer.play("RESET")



func _on_DonateButton_pressed():
	OS.shell_open('https://www.patreon.com/chunkydev')

