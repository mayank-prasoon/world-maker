extends Control

# === NODES ===
onready var pin_name_node:LineEdit            = $MapPinInspector/VBoxContainer/PinName/HBoxContainer/LineEdit
onready var template_select_node:OptionButton = $MapPinInspector/VBoxContainer/PinTemplate/HBoxContainer/OptionButton
onready var pin_x_location_node:SpinBox       = $MapPinInspector/VBoxContainer/PinPosition/HBoxContainer/HBoxContainer/HBoxContainer/SpinBox
onready var pin_y_location_node:SpinBox       = $MapPinInspector/VBoxContainer/PinPosition/HBoxContainer/HBoxContainer/HBoxContainer2/SpinBox2
onready var pin_article_node:LineEdit         = $MapPinInspector/VBoxContainer/PinArticle/HBoxContainer/OptionButton
onready var create_pin_article_node:Button    = $MapPinInspector/VBoxContainer/CreateArticle/HBoxContainer/NewArticle

# === RESOURCE FILE ===
var resource_file:MapPin = MapPin.new()
var map_pin_node         = Node2D.new()

var pin_texture_location = ""

var pin_templates:Array


# ------------------------------------------------------------------------------

func _ready() -> void:
	add_to_group("map_pin_inspector")

	pin_name_node.text = resource_file.pin_name

	load_pin_template()
	
	pin_x_location_node.value = resource_file.pin_location.x
	pin_y_location_node.value = resource_file.pin_location.y

	pin_article_node.text     = resource_file.pin_article.get_path()

	for node in get_tree().get_nodes_in_group('map_inspector_input_field'):
		node.connect('input_value_changed', self, 'input_value_changed')

# ------------------------------------------------------------------------------

func load_pin_template()->void:
	template_select_node.items = []

	var template_save_path:String = SystemDataManager.root_pin_temp_save_path

	pin_templates.append("null")
	
	var temp_array = FolderManager.fetch_files_from(template_save_path.get_base_dir())
	pin_templates.append_array(temp_array)
	
	var index = pin_templates.find(resource_file.pin_symbol_template)
	
	template_select_node.add_item("template")
	template_select_node.set_item_disabled(0, true)
	
	for template in temp_array:
		template_select_node.add_icon_item(
		ImageHandler.load_icon(template.template_texture),
		template.template_name
	)

	if index != -1: 
		$MapPinInspector/VBoxContainer/PinTemplate.input_value = index
		$MapPinInspector/VBoxContainer/PinTemplate.assign_texture(index)
		
		template_select_node.selected = index

# ------------------------------------------------------------------------------

func input_value_changed()->void:

	resource_file.pin_name            = $MapPinInspector/VBoxContainer/PinName.input_value
	resource_file.pin_location        = $MapPinInspector/VBoxContainer/PinPosition.input_value
	resource_file.pin_article         = $MapPinInspector/VBoxContainer/PinArticle.input_value
	resource_file.tags                = $MapPinInspector/VBoxContainer/PinTags.input_value
	
	if $MapPinInspector/VBoxContainer/PinTemplate.input_value is int:
		resource_file.pin_symbol_template = pin_templates[$MapPinInspector/VBoxContainer/PinTemplate.input_value]
	else:
		resource_file.pin_symbol_template = pin_templates[0]

	reload_pin()

# ------------------------------------------------------------------------------

func reload_pin()->void:
#	map_pin_node.queue_free()
	map_pin_node.pin_resource = resource_file
	map_pin_node.add_animation_and_texture()
	map_pin_node.load_resource()
	
#	var load_pin:PackedScene  = load("res://systems/map_system/ui_elements/map_pin/MapPin.tscn")
#	map_pin_node              = load_pin.instance()
#
#	get_parent().get_owner().get_node("PinCollectionNode").add_child(map_pin_node) 

	save_pin()


func save_pin()->void:
	ResourceManager.save_file(
		{
			"pin_name"            : resource_file.pin_name,
			"pin_id"              : resource_file.pin_id,
			"pin_location"        : resource_file.pin_location,
			"pin_symbol_template" : resource_file.pin_symbol_template,
			"pin_article"         : resource_file.pin_article,
			"linked_map"          : resource_file.linked_map,
			"linked_map_location" : resource_file.linked_map_location,
			"tags"                : resource_file.tags
		},

		ResourceManager.PIN
	)

# ------------------------------------------------------------------------------

func _on_DeletePinButton_pressed():
	EventBus.emit_signal("remove_map_pin", resource_file)
	EventBus.emit_signal("clear_inspector")
	map_pin_node.queue_free()


# create new map article
func _on_NewArticle_pressed():
	var uuid = UUID.generate()
	
	Resource.new()
	
	var resource_template = load(resource_file.pin_symbol_template.template_default_article_template)
	if !(resource_template == null):
		resource_template = resource_template.new()
	
	ResourceManager.save_file(
		{
			'article_name'     : resource_file.pin_name,
			'article_id'       : uuid,
			'tags'             : resource_file.tags,
			'article_profile'  : resource_file.pin_symbol_template.template_texture,
			'article_type'     : Article.PIN,
			'article_template' : resource_template
		},
		
		ResourceManager.ARTICLE
	)
	
	var pin_article = load(Article.fetch_save_path().format({"uuid" : uuid}))
	pin_article_node.text     = Article.fetch_save_path().format({"uuid" : uuid})
	resource_file.pin_article = pin_article
	save_pin()
