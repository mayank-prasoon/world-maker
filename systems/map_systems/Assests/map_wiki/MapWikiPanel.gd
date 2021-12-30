extends Control

# === NODES ===

onready var animation: = $PanelBackground/Animaion

func _ready():
	animation.pop(true)
