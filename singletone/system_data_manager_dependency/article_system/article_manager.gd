extends Node

onready var root_node:Node   = self.get_parent().get_parent()
onready var save_system:Node = self.get_parent().get_node("SaveSystem")

func get_tags(article_name:String) -> Array:
	var _temp_article_resource:Resource  = save_system.open_file(article_name)
	var tags:Array                       = _temp_article_resource.tags
	return tags
