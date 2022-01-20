extends Node 

# nodes
onready var grid:GridContainer = $"../ScrollContainer/GridContainer"

# const
const CARD_SIZE:int           = 180
const SEPRASTION_CONSTANT:int = 30

# variables
var screen_size:Vector2

# loop
func _process(_delta):
	change_grid()

# methods
func change_grid()->void:
	var grid_columns:int = int(round(screen_size.x/(CARD_SIZE + SEPRASTION_CONSTANT)))
	
	# this is to ensure a clean look
	if (grid_columns >= 2):
		grid.columns         = (grid_columns - 1)
	else:
		grid.columns         = 1

func _on_GridContainer_item_rect_changed():
	screen_size = OS.window_size

