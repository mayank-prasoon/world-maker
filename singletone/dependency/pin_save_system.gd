extends Node

# === NODES ===
 
onready var root_node:Node = self.get_parent().get_parent()

# === VARIABLES ===

onready var save_location = self.root_node.root_save_file_path + '/pins/{uuid}_save_data.tres' 

# === EXPORTS ===


# save file
func save_file(
		pin_name:String,
		pin_id:String       = root_node.uuid_util.v4(),
		template:Resource   = MapSymbolTemplate.new(),
		location:Vector2    = Vector2(0,0),
		article:Resource    = Resource.new(),
		link_state:bool     = false,
		chunk_link:Resource = MapChunkData.new(),
		tags:Array          = []
	) -> void:

	var newSavePin                  = root_node.mapPin.new()
	newSavePin.pin_name             = pin_name
	newSavePin.pin_id               = pin_id
	newSavePin.pin_symbol_template  = template
	newSavePin.pin_location         = location
	newSavePin.pin_article          = article
	newSavePin.map_link_state       = link_state
	newSavePin.linked_chunk         = chunk_link
	newSavePin.tags                 = tags

	var _x = ResourceSaver.save(
		save_location.format({"uuid": pin_id}),
		newSavePin
	)

# open file
func open_file(pin_id:String)->Resource:
	root_node.verify(
		save_location.format({"uuid": pin_id}),
		root_node.MAP_RESOURCE_TYPE.PIN, pin_id
	)
	
	return ResourceLoader.load(save_location.format({"uuid": pin_id}))

# remove all file
func remove_all_files() -> void:
	var folder = Directory.new()
	var base_folder = save_location.get_base_dir()

	if folder.dir_exists(base_folder):
		folder.open(base_folder)
		folder.list_dir_begin()
		while true:
			var file = folder.get_next()
			if file == "":
				break
			elif not file.begins_with("."):
				folder.remove(base_folder + '/' + file)
		folder.list_dir_end()

# removes file
func remove_file(pin_id:String) -> void:
	var file = Directory.new()
	file.remove(save_location.format({"uuid": pin_id}))
