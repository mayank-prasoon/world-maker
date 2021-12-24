extends Node

onready var root_node:Node   = self.get_parent().get_parent()
onready var save_system:Node = self.get_parent().get_node("SaveSystem")

func _ready()->void:
	LoggingSystem.log_new_event(name + " - node loaded")

func get_tags(article_name:String) -> Array:
	LoggingSystem.log_new_event(name + " - " + "get_tags({0})".format([article_name]))
	var _temp_article_resource:Resource  = save_system.open_file(article_name)
	var tags:Array                       = _temp_article_resource.tags

	CommandSystem.API.echo("list of all the tags: {0}".format([str(tags)]))

	return tags
