extends Control

onready var symbolSystemInventory:Node = $"../SymbolData"

func _on_DropDownName_item_selected(index: int) -> void:
	symbolSystemInventory.symbolTemplateIndex = index
	symbolSystemInventory.assignTemplate(index)


func _on_InputName_text_changed(new_text: String) -> void:
	symbolSystemInventory.symbolNameText = new_text
