extends Panel

signal generate_map(map_name, map_texture, map_chunk_size)

# === node ===
onready var map_name:LineEdit        = $VBoxContainer2/VBoxContainer/LineEdit
onready var map_texture:LineEdit     = $VBoxContainer2/VBoxContainer2/HBoxContainer/LineEdit
onready var map_chunk_size_x:SpinBox = $VBoxContainer2/VBoxContainer3/HBoxContainer/ChunkX
onready var map_chunk_size_y:SpinBox = $VBoxContainer2/VBoxContainer3/HBoxContainer/Chunky

# main loop
func _process(_delta):
	if (map_name.text != "") and (map_texture.text != ""):
		$VBoxContainer2/CreateButton.disabled = false
	else:
		$VBoxContainer2/CreateButton.disabled = true


func _ready():
	# === connect signals ===
	
	# map manager
	var map_manager:Node = self.get_parent().get_owner().get_node("MapManager")
	self.connect("generate_map", map_manager, "_on_MapCreator_generate_map")
	
	# map save system
	var map_save_system = get_node("/root/SystemDataManager").get_node("MapSystem/SaveSystem")
	map_save_system.connect("data_saved", self, "hide_map_creator")
	
	create_confirmation_dialog()

# generate confirmation dialog
func create_confirmation_dialog():
	# ConfirmationDialog
	var new_pop_up:ConfirmationDialog = ConfirmationDialog.new()
	new_pop_up.name            = "ConfirmationDialog"
	new_pop_up.window_title    = "Please Confirm..."
	new_pop_up.dialog_text     = "you are closing the map creation dialog box,\n\nnote: all filled info will be lost"
	new_pop_up.dialog_autowrap = true
	new_pop_up.rect_size       = Vector2(300, 150)

	# Label
	var lable:Label            = new_pop_up.get_child(1)
	lable.align                = Label.ALIGN_CENTER
	lable.valign               = Label.VALIGN_CENTER
	
	var _x = new_pop_up.connect("confirmed", self, "close_the_dialog")
	self.add_child(new_pop_up)

# emit signal generate map
func _on_CreateButton_pressed():
	emit_signal(
			"generate_map",
			map_name.get_text(),
			map_texture.get_text(),
			
			Vector2(
				map_chunk_size_x.get_value(),
				map_chunk_size_y.get_value()
			)
	)

	self.visible = false


func _on_Button_pressed():
	$FileDialog.popup_centered()


func _on_FileDialog_file_selected(path):
	map_texture.text = path
	assign_chunk_number()


func _on_ChunkX_value_changed(_value):
	assign_chunk_number()


func _on_Chunky_value_changed(_value):
	assign_chunk_number()


# display the number of chunks that will be generated 
func assign_chunk_number():
	# get the node
	var map_generator = SystemDataManager.get_node("MapSystem/MapchunkGenerator")
	var chunk_counter:SpinBox = $VBoxContainer2/VBoxContainer3/HBoxContainer/LineEdit3

	var x:Image = map_generator.load_image(map_texture)

	# check if the x
	if !(x.is_empty()):
		chunk_counter.set_value(map_generator.get_chunk_count()) 
	else:
		chunk_counter.set_value(0)


# hide dialog box
func hide_map_creator():
	if (map_name.get_text().empty()) and (map_texture.get_text().empty()):
		# check if the fields are filled
		close_the_dialog()
	else:
		# display the dialog box if the fields are empty
		var confirm:ConfirmationDialog  = self.get_node("ConfirmationDialog")
		confirm.popup_centered()


# close the dialog box~
func close_the_dialog():
	self.queue_free()
