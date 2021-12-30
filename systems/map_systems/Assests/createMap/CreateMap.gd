extends Control

onready var mapNameNode:                = $Background/Name/HBoxContainer/FieldType
onready var map_editor:                 = get_tree().get_root().get_node('/root/Map/MapEditor')
onready var loadingScreen:              = get_tree().get_root().get_node('/root/Map/Camera2D/CanvasLayer/LoadingScreen')
onready var dropdownOption:OptionButton = get_tree().get_root().get_node('/root/Map/Camera2D/CanvasLayer/MapMenu/Menu/SelectMapMenu/OptionButton')

var mapTexture:Texture
var mapTextureLocation:String
var mapName:String

var openCreateMap:bool

func playAnimation() -> void:
	self.show()
	get_tree().call_group('background', 'blurBackground')
	get_tree().call_group('camera_movement', 'changeStateTo', true)
	$Animaion.popBounce()


func _on_Button_pressed() -> void:
	$Button.focus_mode = Control.FOCUS_NONE
	closeAnimation()


func closeAnimation() -> void:
	get_tree().call_group('background', 'unBlurBackground')
	get_tree().call_group('camera_movement', 'changeStateTo', false)
	$Animaion.popBounceBack()


func _on_New_pressed() -> void:
	map_editor.newAddMap(mapNameNode.text, mapTextureLocation)
	closeAnimation()
	closeLoadingAnimation()
	dropdownOption.selected += 1
	SystemMapData.currentMapIndex += 1
	map_editor.changeAddMap(mapTextureLocation)


func closeLoadingAnimation() -> void:
	loadingScreen.hide()
	loadingScreen.animation.play("change")
	loadingScreen.show()


func _on_CreateMap_item_rect_changed() -> void:
	self.rect_pivot_offset = self.get_size()/2
