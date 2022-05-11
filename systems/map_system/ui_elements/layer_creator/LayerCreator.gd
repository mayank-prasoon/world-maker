extends Panel

signal create_layer(layer_name, layer_texture, article)

# === node ===
onready var layer_name:LineEdit        = $HBoxContainer/CenterContainer2/InputField/MapName/Input/LineEdit
onready var layer_texture:LineEdit     = $HBoxContainer/CenterContainer2/InputField/MapTexture/HBoxContainer/Input/LineEdit
onready var layer_shader:LineEdit      = $HBoxContainer/CenterContainer2/InputField/Shader/HBoxContainer/Input/LineEdit

onready var create_button:Button       = $HBoxContainer/CenterContainer2/InputField/CreateButton/CreateButton

var layer_node  = null
var layer_index = -1

# main loop
func _process(_delta)->void:
	if (layer_name.text != "") or (layer_texture.text != ""):
		create_button.disabled = false
	else:
		create_button.disabled = true

# initialize
func _ready()->void:
	EventBus.emit_signal("disable_camera", true)
	
	# === connect signals ===

	# layer manager
	var map:Control = self.get_parent().get_owner()
	var _x = self.connect("create_layer", map, "create_layer")


func edit_mode(layer_resource:MapLayer, node:Control, index:int)->void:
	self.layer_name.text    = layer_resource.layer_name
	self.layer_texture.text = layer_resource.layer_path
	self.layer_shader.text  = layer_resource.layer_custom_shader.get_path()
	self.layer_node         = node
	self.layer_index        = index
	
	if !(layer_resource.layer_path == ""):
		$HBoxContainer/CenterContainer/TextureRect.texture = ImageHandler.load_image_texture(layer_resource.layer_path)

# generate confirmation dialog
func create_confirmation_dialog()->void:
	# ConfirmationDialog
	var new_pop_up:ConfirmationDialog = ConfirmationDialog.new()
	new_pop_up.name            = "ConfirmationDialog"
	new_pop_up.window_title    = "Please Confirm..."
	new_pop_up.dialog_text     = "you are closing the layer creation dialog box,\n\nnote: all filled info will be lost"
	new_pop_up.dialog_autowrap = true
	new_pop_up.rect_size       = Vector2(300, 150)

	# Label
	var lable:Label            = new_pop_up.get_child(1)
	lable.align                = Label.ALIGN_CENTER
	lable.valign               = Label.VALIGN_CENTER
	
	var _x = new_pop_up.connect("confirmed", self, "close_the_dialog")
	self.add_child(new_pop_up)


# emit signal generate map
func _on_CreateButton_pressed()->void:
	var layer_resources:MapLayer = MapLayer.new()

	# assign layer data
	layer_resources.layer_name          = layer_name.get_text()
	layer_resources.layer_path          = layer_texture.get_text()
	layer_resources.layer_custom_shader = load(layer_shader.get_text())

	# layer
	if layer_node != null:
		layer_node.queue_free()
	
	# emit signal to create layer
	emit_signal(
			"create_layer",
			layer_resources,
			layer_index
		)

	self.close_the_dialog()


# close the dialog box~
func close_the_dialog()->void:
	EventBus.emit_signal("disable_camera", false)
	$"../../AnimationPlayer".play("close")

# --------------------------------------------------------------------------------------


func _on_OpenTexture_file_selected(path)->void:
	layer_texture.text  = path
	var file = File.new()
	if !(path == "" or file.file_exists(path)):
		$HBoxContainer/CenterContainer/TextureRect.texture = ImageHandler.load_image_texture(path)


func _on_OpenCustomShader_file_selected(path)->void:
	layer_shader.text   = path


# hide dialog box
func hide_map_creator()->void:
	if (layer_name.get_text().empty()) and (layer_texture.get_text().empty()):
		# check if the fields are filled
		close_the_dialog()
	else:
		# display the dialog box if the fields are empty
		create_confirmation_dialog()
		var confirm:ConfirmationDialog  = self.get_node("ConfirmationDialog")
		confirm.popup_centered()
		if confirm.is_connected("confirmed", self, "close_the_dialog"):
			var _x = confirm.connect("confirmed", self, "close_the_dialog")


func _on_OpenBrowser_pressed()->void:
	$OpenTexture.popup_centered()


func _on_AddCustomShader_pressed()->void:
	$OpenCustomShader.popup_centered()
