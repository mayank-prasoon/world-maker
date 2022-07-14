class_name PinSystem
extends Reference

# make new pin
static func make_new_pin(
		new_pin_name:String,
		pin_template:MapSymbolTemplate = MapSymbolTemplate.new(),
		pin_location:Vector2           = Vector2(0,0),
		pin_article:Article        = Article.new(),
		map_link_state:bool            = false,
		linked_chunk:Vector2           = Vector2(0,0),
		tags:Array                     = []
	)->String:

	var uuid = UUID.generate()

	if !map_link_state:
		linked_chunk = Vector2(0, 0)

	ResourceManager.save_file(
		{
			'pin_name'            : new_pin_name,
			'pin_id'              : uuid,
			'pin_symbol_template' : pin_template,
			'pin_location'        : pin_location,
			'pin_article'         : pin_article,
			'map_link_state'      : map_link_state,
			'linked_chunk'        : linked_chunk,
			'tags'                : tags
		},

		ResourceManager.PIN
		
	)
	
	CommandSystem.API.echo("new pin generated")

	return uuid

static func add_chunk(pin_id:String, chunk:Vector2)->void:
	var temp_file = ResourceManager.open_file(pin_id, ResourceManager.PIN)

	ResourceManager.save_file(
		{
			'pin_name'            : temp_file.pin_name,
			'pin_id'              : temp_file.pin_id,
			'pin_symbol_template' : temp_file.pin_symbol_template,
			'pin_location'        : temp_file.pin_location,
			'pin_article'         : temp_file.pin_article,
			'map_link_state'      : true,
			'linked_chunk'        : chunk,
			'tags'                : temp_file.tags
		},
		
		ResourceManager.PIN
	)

	CommandSystem.API.echo("{chunk} chunk linked to pin: {pin_name}".format({'pin_name':pin_id, 'chunk':str(chunk)}))

static func add_article(pin_id:String, article:Article)->void:
	var temp_file = ResourceManager.open_file(pin_id, ResourceManager.PIN)
	
	ResourceManager.save_file(
		{
			'pin_name'            : temp_file.pin_name,
			'pin_id'              : temp_file.pin_id,
			'pin_symbol_template' : temp_file.pin_symbol_template,
			'pin_location'        : temp_file.pin_location,
			'pin_article'         : article,
			'map_link_state'      : temp_file.map_link_state,
			'linked_chunk'        : temp_file.linked_chunk,
			'tags'                : temp_file.tags
		},

		ResourceManager.PIN
	)
	
	CommandSystem.API.echo("{article} article added to pin: {pin_name}".format({'pin_name':pin_id, 'article':str(article)}))

static func remove_tags(pin_id:String, tags:Array)->void:
	var temp_file = ResourceManager.open_file(pin_id, ResourceManager.PIN)
	
	for tag in tags:
		temp_file.tags.remove(temp_file.tags.find(tag))
	
	ResourceManager.save_file(
		{
			'pin_name'            : temp_file.pin_name,
			'pin_id'              : temp_file.pin_id,
			'pin_symbol_template' : temp_file.pin_symbol_template,
			'pin_location'        : temp_file.pin_location,
			'pin_artilce'         : temp_file.pin_article,
			'map_link_state'      : temp_file.map_link_state,
			'linked_chunk'        : temp_file.linked_chunk,
			'tags'                : temp_file.tags
		},

		ResourceManager.PIN
	)
	
	CommandSystem.API.echo("{tags} tags remove from pin: {pin_name}".format({'pin_name':pin_id, 'tags':str(tags)}))

static func add_tags(pin_id:String, tags:Array)->void:
	var temp_file = ResourceManager.open_file(pin_id, ResourceManager.PIN)

	temp_file.tags.append_array(tags)

	ResourceManager.save_file(
		{
			'pin_name'            : temp_file.pin_name,
			'pin_id'              : temp_file.pin_id,
			'pin_symbol_template' : temp_file.pin_symbol_template,
			'pin_location'        : temp_file.pin_location,
			'pin_artilce'         : temp_file.pin_article,
			'map_link_state'      : temp_file.map_link_state,
			'linked_chunk'        : temp_file.linked_chunk,
			'tags'                : temp_file.tags
		},

		ResourceManager.PIN
	)
	
	CommandSystem.API.echo("{tags} tags added to pin: {pin_name}".format({'pin_name':pin_id, 'tags':str(tags)}))

static func get_pins_with_tag(tag_name:String)->Array:
	var base_folder = SystemDataManager.root_pin_save_path.get_base_dir()

	var pins = FolderManager.fetch_files_from(base_folder)
	
	var temp_pins = []
	
	for i in range(pins.size()):
		if (pins[i].tags.has(tag_name)):
			temp_pins.append(pins[i])

	CommandSystem.API.echo("list of all the pin: {0}".format([str(pins)]))
	return temp_pins
