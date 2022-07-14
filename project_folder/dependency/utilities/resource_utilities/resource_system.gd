
# ============================================================================ #
#                               RESOURCE SYSTEM                                # 
# ============================================================================ #

# this class deals with loading resources


class_name ResourceSystem
extends Reference

# creates a cache file to store
class CacheSystem:
	static func create_image_cache(path:String, name:String, new_path:String)->void:

		# check if the path exists
		if ResourceLoadSystem.FileChecker.check_file_exists(path) == OK:
			var texture:ImageTexture = ImageHandler.load_image_texture(path)
			if ResourceUtilies.NullCheck.check_for_null(texture) == OK:
				ResourceSaveSystem.save_resource(new_path, texture)

# ------------------------------------------------------------------------------

class MoveSystem:
	static func move(path:String, new_path:String)->void:
		if ResourceLoadSystem.FileChecker.check_file_exists(path) == OK:
			var dir:Directory = Directory.new()
			ResourceSaveSystem.CheckFolderIntregety.check(new_path) # check if the path exists
			dir.copy(path, new_path)
