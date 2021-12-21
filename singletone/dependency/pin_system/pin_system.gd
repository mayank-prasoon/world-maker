extends Node

onready var root_node     = self.get_parent()
onready var save_system   = self.get_node("SaveSystem")
onready var system_manger = self.get_node("PinManager")
var save_location:String

func _ready():
	save_location = root_node.root_save_file_path + '/pins/{uuid}_save_data.tres'

# make new pin
func make_new_pin(
		new_pin_name:String,
		pin_template:MapSymbolTemplate,
		pin_location:Vector2,
		pin_article:RootArticle,
		map_link_state:bool,
		linked_chunk:MapChunkData,
		tags:Array
)->String:
	var uuid = get_parent().uuid_util.v4()

	if !map_link_state:
		linked_chunk = MapChunkData.new()

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
	
	return uuid

func add_chunk(pin_name:String, chunk:MapChunkData)->void:
	var temp_file = save_system.open_file(pin_name)
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


func add_article(pin_name:String, article:RootArticle)->void:
	var temp_file = save_system.open_file(pin_name)
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


func remove_tags(pin_name:String, tags:Array)->void:
	var temp_file = save_system.open_file(pin_name)
	
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

func add_tags(pin_name:String, tags:Array)->void:
	var temp_file = save_system.open_file(pin_name)

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


func get_pins_with_tag(tag_name:String)->Array:
	var pins = []
	
	var folder      = Directory.new()
	var base_folder = save_location.get_base_dir()
	if folder.dir_exists(base_folder):
		folder.open(base_folder)
		folder.list_dir_begin()
		while true:
			var file = folder.get_next()
			if file == "":
				break
			elif not file.begins_with("."):
				var temp_pin = load(base_folder + "/" + file)
				if temp_pin.tags.has(tag_name):
					pins.append(temp_pin)
		folder.list_dir_end()
	return pins
	
