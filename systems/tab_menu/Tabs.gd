extends Control

func _on_map_pressed() -> void:
	var _change: = get_tree().change_scene("res://Scene/map/Map.tscn")

func _on_FamilyTree_pressed() -> void:
	var _change: = get_tree().change_scene("res://Scene/family_tree/FamilyTree.tscn")

func _on_Timeline_pressed() -> void:
	var _change: = get_tree().change_scene("res://Scene/timeline/Timeline.tscn")


func _on_Rules_pressed() -> void:
	pass

func _on_Note_pressed() -> void:
	var _change: = get_tree().change_scene("res://Scene/notes/Notes.tscn")


func _on_Stats_pressed() -> void:
	pass


func _on_Character_pressed() -> void:
	var _change: = get_tree().change_scene("res://Scene/character_worksheet/CharacterWorkSheet.tscn")


func _on_bestiary_pressed() -> void:
	var _change: = get_tree().change_scene("res://Scene/bestiary_worksheet/BestiaryWorksheet.tscn")
