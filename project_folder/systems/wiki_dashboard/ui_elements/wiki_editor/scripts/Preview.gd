extends Control

@onready var vbox_container:VBoxContainer = $"../TextEditor/Panel/TabContainer/Prompts/ScrollContainer/VBoxContainer"
@onready var rich_text:RichTextLabel      = $VBoxContainer/RichTextLabel
@onready var basic_tab                    = $"../TextEditor/Panel/TabContainer/Basic/ScrollContainer/VBoxContainer"
@onready var notes                        = $"../TextEditor/Panel/TabContainer/Notes/VBoxContainer/TextEdit"
@onready var preview_title                = $VBoxContainer/HBoxContainer/Label

func _ready():
	rich_text.bbcode_enabled = true

func update_preview():
	rich_text.text = get_owner().fetch_raw_data()

func update_title():
	var title = basic_tab.get_node("Article Name")

	if !title.input_value == "":
		preview_title.text = title.input_value
		preview_title.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		preview_title.text = 'Untitled'
		preview_title.modulate = Color(1.0, 1.0, 1.0, 0.5)


func _on_WikiEditor_data_changed():
	update_title()
	update_preview()
