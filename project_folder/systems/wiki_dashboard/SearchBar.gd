extends Control

func _ready()->void:
	for filters in $FilterPopup/Panel/VBoxContainer.get_children():
		filters.connect('toggled', self, 'change_in_filter')


func _on_Button_pressed()->void:
	$FilterPopup.rect_global_position = $CenterContainer/SearchBar/TextureRect/CenterContainer/Button.rect_global_position + Vector2(-30, 60)
	$FilterPopup.popup()

func change_in_filter(_state)->void:
	$"../CardList/CardManager".get_article($CenterContainer/SearchBar/TextureRect2/CenterContainer/LineEdit.get_text())
