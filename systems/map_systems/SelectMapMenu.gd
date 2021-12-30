extends Control

signal change_map(index)

onready var optionbutton:  = $OptionButton
onready var addmap:        = $"AddMap"
onready var mapEditor:     = $"../../../../../MapEditor"
onready var loadingScreen: = $"../../../LoadingScreen"

func _ready() -> void:
	add_to_group('create_map')


func _on_AddMap_pressed() -> void:
	createNewMap()
	
func createNewMap() -> void:
	addmap.focus_mode = Control.FOCUS_NONE
	var createMap = get_tree().get_root().get_node('/root/Map/Camera2D/CanvasLayer/CreateMap')
	createMap.show()
	createMap.playAnimation()

func addMap(maps:String) -> void:
	$OptionButton.add_item(maps)

func _on_OptionButton_item_selected(index: int) -> void:
	loadingScreen.hide()
	loadingScreen.animation.play("change")
	loadingScreen.show()
	emit_signal("change_map", index)
