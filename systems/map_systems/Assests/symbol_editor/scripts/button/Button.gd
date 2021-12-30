extends Button

onready var symbolData:Node    = $"../SymbolData"
onready var symbolCreator:Node = $"../SymbolCreator"

func _on_Button_pressed() -> void:
	symbolData.symbolNameText = symbolData.symbolName.text
	symbolCreator.instanceLocation(symbolData.symbolTemplateIndex)
