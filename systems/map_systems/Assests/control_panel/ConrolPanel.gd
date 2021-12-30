extends Control

# === VERIABLES ===

onready var state:bool             = $Button.pressed
# mouse position 
onready var mousePosition:Vector2  = Vector2()
onready var button:Button          = $Button

onready var position:Vector2       = $"PanelBackground".get_position()
onready var buttonPosition:Vector2 = self.button.get_position()

# === INITIALISATION ===

func _ready():
# initialize animation 
	Vector2(get_position())
	slide_aniamtion(state)

# === FUNCTIONS ===

func slide_aniamtion(button_pressed:bool)->void:
# this controls the slide animation of the whole menu
# button_pressed : it is the bool value the control the state of the the whole menu
	state = button_pressed
	
	$Button/TextureRect/Animaion.rotate(button_pressed)
	$Button/Animaion.slide(
		!button_pressed,
		Vector2(buttonPosition),
		Vector2(OS.window_size.x - 35, $Button.get_position().y)
	)
	$PanelBackground/Animaion.slide(
		!button_pressed,
		Vector2(position),
		Vector2(OS.window_size.x, 74)
	)

# === SIGNAL METHODS ===

func _on_Button_toggled(button_pressed:bool)->void:
	slide_aniamtion(button_pressed)
