
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
var map_name:String

func _ready()->void:
	Logger.info(name + " node loaded")
	save_location = get_parent().root_save_file_path + '/maps/{uuid}_save_data.tres'


# return the array of map resources paths
func get_maps()->Array:
	Logger.info(name + " - " + "get_articles()")
	
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
func generate_map(map_name:String, img_path:String, chunk_size:Vector2 = Vector2(512, 288)):
	map_gen.slice_texture(img_path)
	self.map_name = map_name

# save the map
func save_map(map_tile:String, chunk_count:int):
	save_system.save_file(
		map_name,
		map_tile,
		Vector2(sqrt(chunk_count), sqrt(chunk_count)),
		chunk_count
	)

