extends Node

# === EXPORTS ===
# this is a packed scene which is a template for the map pin in the addSymbol() method
export(PackedScene) var icon:PackedScene = preload("res://Scene/map/Assests/location/Location.tscn")

# === NODES === 
onready var CAMERA:Camera2D       = $"../Camera2D"
onready var SYMBOL_EDITOR:Control = $"../Camera2D/CanvasLayer/ConrolPanel"
onready var LOCATIONS:Control     = $"../MapEditor/Locations"

# === VERIABLES === 
# this is the base postion for the location of the map pin.
# this will change with the mouse position on right clicking on map to add map pin
var symbolPosition:Vector2 = Vector2(0,0)

# === FUNCTIONS === 
func addSymbol() -> void:
# This add the map pin on right clicking on the map
	symbolPosition = CAMERA.get_global_mouse_position()

	if SYMBOL_EDITOR.state == true:
		SYMBOL_EDITOR.slide_aniamtion(false)
		SYMBOL_EDITOR.button.pressed = false
		# this add the pin ot the position of the mouse
		SYMBOL_EDITOR.mousePosition = CAMERA.get_global_mouse_position()
		moveThecamera()

func moveThecamera() -> void:
# this move the map so that the map pin is in the center of the screen
	CAMERA.desiredOffset = CAMERA.get_global_mouse_position() - OS.get_window_size()

# === SIGNALS CONNECTION === 

# === UNUSED CODE ===
