extends Node

onready var symbolName:LineEdit           = $"../LocationEditor/InputName"
onready var symbolBannerLocation:LineEdit = $"../Description/LineEdit"
onready var symbolDescription:TextEdit    = $"../Description/TextEdit"
onready var symbolTexture:TextureRect     = $"../LocationEditor/Location/TextureRect"
onready var symbolTemplate:OptionButton   = $"../LocationEditor/DropDownName"

var symbolNameText:String                 = ""
var symbolTemplateIndex:int               = 0

#func _ready() -> void:
#	self.assignTemplate(0)
#	for x in SystemIconData.iconName.size():
#		symbolTemplate.add_item(SystemIconData.iconName[x], x)

func isFieldEmpty() -> bool:
	if symbolNameText == "":
		return true
	else:
		return false

func assignTemplate(index:int) -> void:
	symbolTexture.texture = load(SystemIconData.iconTexture[index])
