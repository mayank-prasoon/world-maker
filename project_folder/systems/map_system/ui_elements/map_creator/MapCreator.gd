extends Panel

# === node ===
@onready var map_name:LineEdit        = $HBoxContainer/CenterContainer2/InputField/MapName/Input/LineEdit
@onready var map_texture:LineEdit     = $HBoxContainer/CenterContainer2/InputField/MapTexture/HBoxContainer/Input/LineEdit
@onready var create_article:CheckBox  = $HBoxContainer/CenterContainer2/InputField/HBoxContainer2/CheckBox
@onready var create_button:Button     = $HBoxContainer/CenterContainer2/InputField/CreateButton/CreateButton

#onready var map_chunk_size_x:SpinBox = $VBoxContainer2/VBoxContainer3/HBoxContainer/ChunkX
#onready var map_chunk_size_y:SpinBox = $VBoxContainer2/VBoxContainer3/HBoxContainer/Chunky


func _ready()->void:
	EventBus.emit_signal("disable_camera", true)


# main loop
func _process(_delta:float)->void:
	if (map_name.text != "") and (map_texture.text != ""):
		create_button.disabled = false
	else:
		create_button.disabled = true


# generate confirmation dialog
func create_confirmation_dialog()->void:
	# ConfirmationDialog
	var new_pop_up:ConfirmationDialog = ConfirmationDialog.new()
	new_pop_up.name            = "ConfirmationDialog"
	new_pop_up.window_title    = "Please Confirm..."
	new_pop_up.dialog_text     = "you are closing the map creation dialog box,\n\nnote: all filled info will be lost"
	new_pop_up.dialog_autowrap = true
	new_pop_up.size       = Vector2(300, 150)

	# Label
	var lable:Label            = new_pop_up.get_child(1)
	lable.align                = Label.ALIGNMENT_CENTER
	lable.valign               = Label.VALIGN_CENTER
	
	var _x = new_pop_up.connect("confirmed",Callable(self,"close_the_dialog"))
	var _y = new_pop_up.connect("confirmed",Callable(new_pop_up,"close_the_dialog"))
	self.add_child(new_pop_up)


# emit signal generate map
func _on_CreateButton_pressed()->void:
	EventBus.emit_signal(
		"create_new_map",
		map_name.get_text(),
		map_texture.get_text(),
		create_article.pressed
	)

	self.close_the_dialog()


func _on_Button_pressed()->void:
	$FileDialog.popup_centered()


func _on_FileDialog_file_selected(path)->void:
	map_texture.text = path
	var file = File.new()
	if !(path == "") or file.file_exists(path):
		$HBoxContainer/CenterContainer/TextureRect.texture = ImageHandler.load_image_texture(path)

# hide dialog box
func hide_map_creator()->void:
	if (map_name.get_text().is_empty()) and (map_texture.get_text().is_empty()):
		# check if the fields are filled
		EventBus.emit_signal("disable_camera", false)
		close_the_dialog()
	else:
		# display the dialog box if the fields are empty
		create_confirmation_dialog()
		var confirm:ConfirmationDialog  = self.get_node("ConfirmationDialog")
		confirm.popup_centered()


# close the dialog box~
func close_the_dialog()->void:
	EventBus.emit_signal("disable_camera", false)
	$AnimationPlayer.play("close")
