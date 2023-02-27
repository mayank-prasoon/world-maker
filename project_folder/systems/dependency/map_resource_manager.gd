# =============================================== #
#               MAP RESOURCE SYSTEM               # 
# =============================================== #

# this deals with map resources 
#
#
#
#

class_name MapResourceSystem
extends RefCounted

# =============================================== #
#               MAP RESOURCE MANAGER              # 
# =============================================== #

# map resource manager

class MapResourceManager extends RefCounted:
	# create new map
	static func create_map_resource(map_name:String, map_texture:String, article:bool)->void:
		# instance and add the loading scene to the scene	
		
		ResourceManager.save_file(
			{
				"map_name"     : map_name,
				"image_path"   : map_texture,
				"tags"         : [],
			},

			ResourceManager.MAP
		)

		if article: # if article needs to be generated
			ResourceManager.save_file(
				{
					'article_name'        : map_name,
					'article_id'          : UUID.generate(),
					'article_resources'   : ResourceManager.resource_path(ResourceManager.MAP).format({'uuid':map_name})
				},
				
				ResourceManager.ARTICLE
			)
	
	# saves map
	static func save_map_resource(map_data_resource:MapData)->void:
		ResourceManager.save_file(
			{
				"map_name"     : map_data_resource.map_name,
				"image_path"   : map_data_resource.image_path,
				"map_size"     : Vector2(0,0), # depricated and need to be removed
				"layers"       : map_data_resource.layers,
				"map_pins"     : map_data_resource.map_pins,
				"tags"         : map_data_resource.tags
			},
			ResourceManager.MAP
		)

class MapPinResourceManager extends RefCounted:
	# create new map pin
	static func create_new_pin_resource(pin_uid:String, pin_location:Vector2)->void:
		ResourceManager.save_file(
			{
				"pin_id"       : pin_uid,
				"pin_location" : pin_location,
				"tags"         : []
			},

			ResourceManager.PIN
		)
	
	# save the map pin resource
	static func save_map_pin_resource(pin_data_resource:MapPin)->void:
		ResourceManager.save_file(
			{
				"pin_name"            : pin_data_resource.pin_name,
				"pin_id"              : pin_data_resource.pin_id,
				"pin_location"        : pin_data_resource.pin_location,
				"pin_symbol_template" : pin_data_resource.pin_symbol_template,
				"pin_article"         : pin_data_resource.pin_article,
				"linked_map"          : pin_data_resource.linked_map,
				"linked_map_location" : pin_data_resource.linked_map_location,
				"tags"                : pin_data_resource.tags
			},

			ResourceManager.PIN
		)
