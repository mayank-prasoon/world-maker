class_name ResourceManager
extends Reference

enum {
		MAP,
		PIN,
		SYMBOL_TEMP,
		ARTICLE
	}

class SaveData extends Object:
	var thread = Thread.new()

	# initailization
	func _init(path, resource):
		thread.start(
			self,
			'save',
			[
				path,
				resource
			]
		)

	# save the resources
	func save(args):
		var path:String       = args[0] 
		var resource:Resource = args[1]

		var _error = ResourceSaver.save(
			path,
			resource
		)

		self.call_deferred('join_thread')

	# join the thread the free it self
	func join_thread():
		thread.wait_to_finish()                                                 # join the thread and wait for it to finish
		self.call_deferred("free")                                              # free the object in the ideal frame


# return the path save location for the resource type
static func resource_path(resource_type:int) -> String:
	
	# path of the resources folder
	var save_location:String

	match resource_type:
		MAP:  # map resouces
			save_location = SystemDataManager.root_save_file_path + \
				"/maps/{uuid}_save_data.tres"
		
		PIN:  # pin resources
			save_location = SystemDataManager.root_save_file_path + \
				"/pins/{uuid}_save_data.tres"

		ARTICLE: # article resources
			save_location = SystemDataManager.root_save_file_path + \
				"/articles/{uuid}_save_data.tres"

		SYMBOL_TEMP: # symbol resources
			save_location = SystemDataManager.root_save_file_path + \
				"/map_symbol_templates/{uuid}_save_data.tres"
	
	return save_location


# save the resource
static func save_file(data:Dictionary, resource_type:int)->void:
	
	# resource
	var resource:Resource
	
	var path:String = resource_path(resource_type) 
	var uuid:String
	
	# resource type
	match resource_type:
		MAP:
			resource = MapData.new()
			uuid     = data.map_name
		PIN:
			resource = MapPin.new()
			uuid     = data.pin_id
		SYMBOL_TEMP:
			resource = MapSymbolTemplate.new()
			uuid     = data.template_name
		ARTICLE:
			resource = Article.new()
			uuid     = data.article_id
	
	# set the property of the resources
	for property in data.keys():
		resource.set(property, data[property])
	
	# save resources
	var _save = SaveData.new(path.format({'uuid':uuid}), resource)


# open the resource and return
static func open_file(item_uid:String, resource_type:int)->Resource:
	var save_location:String = resource_path(resource_type)
	

	SystemDataManager.verify(
		save_location.format({"uuid": item_uid}),
		resource_type,
		item_uid
		)

	# Logger.info(name + " - open_file({0})".format([item_uid]))
	CommandSystem.API.echo("{name} loaded".format({"name": item_uid}))

	var resource = ResourceLoader.load(save_location.format({"uuid": item_uid}))
	
	
	return resource


# remove all the resource files from the folder
static func remove_all_files(resource_type:int):
	var save_location:String = resource_path(resource_type)

	var folder = Directory.new()
	var base_folder = save_location.get_base_dir()
	
	# loop though folder and remove all the files
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
	
	CommandSystem.API.echo("all files removed in the {folder}".format({"folder": base_folder}))


# remove a specific resource files from the folder
static func remove_file(item_uid:String, resource_type:int) -> void:
	var save_location:String = resource_path(resource_type)

	var file = Directory.new()
	file.remove(save_location.format({"uuid": item_uid}))

	CommandSystem.API.echo("removed files: {file}".format({"file": file}))
