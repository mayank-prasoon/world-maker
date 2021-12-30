extends Node

# === SYMBOL === 
onready var symbolName:Node

# === TEMPLATE === 
onready var templateName:LineEdit
onready var templateImage:String 


func checkFieldsSymbol() -> bool:
	if symbolName.text == '':
		return true
	else:
		return false


func checkFieldTemplate() -> bool:
	if templateName.text == '' and templateImage == '':
		return true
	else:
		return false
