extends Node

onready var bbodeEditor:RichTextLabel = $"../HBoxContainer/VBoxContainer3/RichTextLabel"
onready var titleEditor:LineEdit      = $"../HBoxContainer/VBoxContainer/TextEdit"
onready var textEditor:TextEdit       = $"../HBoxContainer/VBoxContainer/TextEdit2"

func _ready():
	pass

func _process(delta):
	bbodeEditor.bbcode_text = '[center]' + titleEditor.text + '[/center]\n' + textEditor.text
