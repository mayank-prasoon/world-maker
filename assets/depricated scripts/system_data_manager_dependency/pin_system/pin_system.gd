extends Node

onready var root_node:Node      = self.get_parent()
onready var save_system:Node    = self.get_node("SaveSystem")
onready var system_manager:Node = self.get_node("PinManager")

var save_location:String

func _ready()-> void:
	save_location = root_node.root_save_file_path + '/pins/{uuid}_save_data.tres'

# make new pin
func make_new_pin(
		new_pin_name:String,
		pin_template:MapSymbolTemplate = MapSymbolTemplate.new(),
		pin_location:Vector2           = Vector2(0,0),
		pin_article:Article        = Article.new(),
		map_link_state:bool            = false,
		linked_chunk:Vector2           = Vector2(0,0),
		tags:Array                     = []
)->String:
	var uuid = get_parent().uuid_util.v4()

	Logger.info(name + " - " + "make_new_pin({0},{1},{2},{3},{4},{5},{6})".format([new_pin_name, pin_template, pin_location, pin_article, map_link_state, linked_chunk, str(tags)]))


	if !map_link_state:
		linked_chunk = Vector2(0, 0)

	save_system.save_file(
			new_pin_name,
			uuid,
			pin_template,
			pin_location,
			pin_article,
			map_link_state,
			linked_chunk,
			tags
	)
	
	CommandSystem.API.echo("new pin generated")

	return uuid

func add_chunk(pin_id:String, chunk:Vector2)->void:
	Logger.info(name + " - " + "add_chunk({0},{1})".format([pin_id, chunk]))

	var temp_file = save_system.open_file(pin_id)
	save_system.save_file(
		temp_file.pin_name,
		temp_file.pin_id,
		temp_file.pin_symbol_template,
		temp_file.pin_location,
		temp_file.pin_article,
		true,
		chunk,
		temp_file.tags
	)

	CommandSystem.API.echo("{chunk} chunk linked to pin: {pin_name}".format({'pin_name':pin_id, 'chunk':str(chunk)}))


func add_article(pin_id:String, article:Article)->void:

	Logger.info(name + " - " + "add_article({0},{1})".format([pin_id, article]))

	var temp_file = save_system.open_file(pin_id)
	save_system.save_file(
		temp_file.pin_name,
		temp_file.pin_id,
		temp_file.pin_symbol_template,
		temp_file.pin_location,
		article,
		temp_file.map_link_state,
		temp_file.linked_chunk,
		temp_file.tags
	)
	
	CommandSystem.API.echo("{article} article added to pin: {pin_name}".format({'pin_name':pin_id, 'article':str(article)}))

func remove_tags(pin_id:String, tags:Array)->void:

	Logger.info(name + " - " + "remove_tags({0},{1})".format([pin_id, str(tags)]))

	var temp_file = save_system.open_file(pin_id)
	
	for tag in tags:
		temp_file.tags.remove(temp_file.tags.find(tag))
	
	save_system.save_file(
		temp_file.pin_name,
		temp_file.pin_id,
		temp_file.pin_symbol_template,
		temp_file.pin_location,
		temp_file.pin_article,
		temp_file.map_link_state,
		temp_file.linked_chunk,
		temp_file.tags
	)
	
	CommandSystem.API.echo("{tags} tags remove from pin: {pin_name}".format({'pin_name':pin_id, 'tags':str(tags)}))

func add_tags(pin_id:String, tags:Array)->void:

	Logger.info(name + " - " + "add_tags({0},{1})".format([pin_id, tags]))

	var temp_file = save_system.open_file(pin_id)

	temp_file.tags.append_array(tags)
	save_system.save_file(
		temp_file.pin_name,
		temp_file.pin_id,
		temp_file.pin_symbol_template,
		temp_file.pin_location,
		temp_file.pin_article,
		temp_file.map_link_state,
		temp_file.linked_chunk,
		temp_file.tags
	)
	
	CommandSystem.API.echo("{tags} tags added to pin: {pin_name}".format({'pin_name':pin_id, 'tags':str(tags)}))

func get_pins_with_tag(tag_name:String)->Array:

	Logger.info(name + " - " + "get_pins_with_tag({0},{1})".format([tag_name]))

	var base_folder = save_location.get_base_dir()

	var pins = FolderManager.fetch_files_from(base_folder)
	
	var temp_pins = []
	
	for i in range(pins.size()):
		if (pins[i].tags.has(tag_name)):
			temp_pins.append(pins[i])

	CommandSystem.API.echo("list of all the pin: {0}".format([str(pins)]))
	return temp_pins
