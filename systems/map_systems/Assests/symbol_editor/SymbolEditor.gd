extends Control

onready var ANIMATION_POPUP:Tween            = $Animaion
onready var ANIMATION_PLAYER:AnimationPlayer = $AnimationPlayer
onready var locations:Control                = $"../../../MapEditor/Locations"

var state:bool = false
var mousePosition:Vector2 

func pop() -> void:
	self.visible = true	
	self.ANIMATION_POPUP.popBounce()
	get_tree().call_group('background', 'blurBackground')
	state = true

func close() -> void:
	self.ANIMATION_POPUP.popBounceBack()
	get_tree().call_group('background', 'unBlurBackground')
	state = false


# === SIGNALS ===
func _on_Button2_pressed() -> void:
	if state:
		close()
	else:
		pass

func _on_SymbolEditor_item_rect_changed() -> void:
	self.rect_pivot_offset = self.get_size()/2
