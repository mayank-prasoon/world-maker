
# ========================================= #
#                   NOTE                    #
# ========================================= #
#                                           #
#   due to map being comprised of images.   #  
#  it is recommended to use multithreading  #
#      to handle creation of maps.          #
#                                           #
#===========================================#

extends Node

# === Nodes ===

onready var save_system:Node    = get_node("SaveSystem")
onready var system_manager:Node = get_node("MapManager")
onready var map_gen:Node        = get_node("MapchunkGenerator")

# === veriables ===

var save_location:String

func _ready()->void:
	Logger.info(name + " node loaded")
	save_location = get_parent().root_save_file_path + '/maps/{uuid}_save_data.tres'


# return the array of map resources paths
func get_maps()->Array:
	Logger.info(name + " - " + "get_articles()")
	
	var folder      = Directory.new()
	var base_folder = save_location.get_base_dir()
	
	# maps
	var maps = FolderManager.fetch_files_from(base_folder, true)
	CommandSystem.API.echo("list of article : {0}".format([str(maps)]))
	
	return maps


#                 === DANGER ZONE ===                   #
# ----------------------------------------------------- #
#    following code are depricated or need a overhaul   #
#                or a work in progress                  #
#                                                       #
#              !!PROCEED WITH CAUTION!!                 #
#                                                       #


# genrate map
func generate_map(map_name:String, img_path:String, chunk_size:Vector2 = Vector2(512, 288), tags:Array = [], pins:Array = []):
	var map_tile:TileSet   = map_gen.slice_texture(img_path)
	var image_size:Vector2 = map_gen.load_image(img_path).get_size()
	var chunk_counter:int  = map_gen.get_chunk_count(image_size, chunk_size)

	save_system.save_file(
		map_name,
		map_tile,
		Vector2(sqrt(chunk_counter), sqrt(chunk_counter)),
		chunk_counter,
		pins,
		tags
	)


# emitted when the the map is saved
func _on_SaveSystem_data_saved():
	print("saved")
