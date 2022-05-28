extends Control

# === NODES ===
onready var pin_name_node:LineEdit            = $MapPinInspector/VBoxContainer/PinName/HBoxContainer/LineEdit
onready var template_select_node:OptionButton = $MapPinInspector/VBoxContainer/PinTemplate/HBoxContainer/OptionButton
onready var pin_x_location_node:SpinBox       = $MapPinInspector/VBoxContainer/PinPosition/HBoxContainer/HBoxContainer/HBoxContainer/SpinBox
onready var pin_y_location_node:SpinBox       = $MapPinInspector/VBoxContainer/PinPosition/HBoxContainer/HBoxContainer/HBoxContainer2/SpinBox2
onready var pin_article_node:LineEdit         = $MapPinInspector/VBoxContainer/PinArticle/HBoxContainer/OptionButton
onready var create_pin_article_node:Button    = $MapPinInspector/VBoxContainer/CreateArticle/HBoxContainer/NewArticle
onready var select_link_map_node:OptionButton = $MapPinInspector/VBoxContainer/LinkMap/HBoxContainer/OptionButton

# === RESOURCE FILE ===
var resource_file:MapPin = MapPin.new()
var map_pin_node         = Node2D.new()

var pin_texture_location = ""

var pin_templates:Array

var map_list:Dictionary

# ------------------------------------------------------------------------------

func _ready() -> void:
	add_to_group("map_pin_inspector")

	pin_name_node.text = resource_file.pin_name

	load_pin_template()
	load_map()

	pin_x_location_node.value = resource_file.pin_location.x
	pin_y_location_node.value = resource_file.pin_location.y

	pin_article_node.text     = resource_file.pin_article.get_path()
	if !(resource_file.linked_map == null):
		var map_index:int         = map_list.values().find(resource_file.linked_map.get_path()) - 1
		select_link_map_node.selected = map_index
	else:
		select_link_map_node.selected = 0
		

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

func load_map()->void:
	select_link_map_node.items = []
	 
	var template_save_path:String = SystemDataManager.root_map_save_path
	
	map_list["null"] = ["null"]

	select_link_map_node.add_item("select a map")
	select_link_map_node.set_item_disabled(0, true)

	var temp_array = FolderManager.fetch_files_from(template_save_path.get_base_dir())
	for map in temp_array:
		map_list[map.map_name] = map.get_path()
		select_link_map_node.add_item(map.map_name)
	


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
	
	resource_file.linked_map          = $MapPinInspector/VBoxContainer/LinkMap.input_value
	
	reload_pin()

# ------------------------------------------------------------------------------

func reload_pin()->void:
	map_pin_node.pin_resource = resource_file
	map_pin_node.add_animation_and_texture()
	map_pin_node.load_resource()
	save_pin()

# ------------------------------------------------------------------------------

func save_pin()->void:
	ResourceManager.save_file(
		{
			"pin_name"            : resource_file.pin_name,
			"pin_id"              : resource_file.pin_id,
			"pin_location"        : resource_file.pin_location,
			"pin_symbol_template" : resource_file.pin_symbol_template,
			"pin_article"         : resource_file.pin_article,
			"linked_map"          : resource_file.linked_map,
			"tags"                : resource_file.tags
		},

		ResourceManager.PIN
	)

# ------------------------------------------------------------------------------

func _on_DeletePinButton_pressed():
	EventBus.emit_signal("remove_map_pin", resource_file)
	EventBus.emit_signal("clear_inspector")
	map_pin_node.queue_free()

# ------------------------------------------------------------------------------

# create new map article
func _on_NewArticle_pressed():
	var uuid = UUID.generate()

	resource_file.pin_article = create_map_pin_article(uuid)
	pin_article_node.text     = Article.fetch_save_path().format({"uuid" : uuid})
	reload_pin()

# ------------------------------------------------------------------------------

func create_map_pin_article(uuid:String)->Article:
	var article_resource = Article.new()

	var resource_template = load(resource_file.pin_symbol_template.template_default_article_template)
	if !(resource_template == null):
		resource_template = resource_template.new()

	var data = {
			'article_name'     : resource_file.pin_name,
			'article_id'       : uuid,
			'tags'             : resource_file.tags,
			'article_profile'  : resource_file.pin_symbol_template.template_texture,
			'article_type'     : Article.PIN,
			'article_template' : resource_template
		}

	for property in data.keys():
		article_resource.set(property, data[property])

	ResourceSaver.save(Article.fetch_save_path().format({"uuid" : uuid}), article_resource)
	var pin_article = load(Article.fetch_save_path().format({"uuid" : uuid}))
	
	return pin_article
