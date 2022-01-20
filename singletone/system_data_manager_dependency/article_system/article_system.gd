extends Node

onready var root_node      = self.get_parent()
onready var save_system    = self.get_node("SaveSystem")
onready var system_manager = self.get_node("ArticleManager")

var save_location:String

func _ready() -> void:
	Logger.info(name + " - node loaded")

	save_location = root_node.root_save_file_path + '/articles/{uuid}_save_data.tres'

# creats new article with new uuid
func make_new_article(
		article_name:String,
		banner:String,
		raw_data:String,
		tags:Array
	)->String:
	var uuid = get_parent().uuid_util.v4()

	Logger.info(name + " - " + "make_new_article({0},{1},{2},{3})".format([article_name, banner, raw_data, str(tags)]))

	save_system.save_file(
			article_name,
			uuid,
			banner,
			raw_data,
			tags
		)

	CommandSystem.API.echo("new article generated")

	return uuid

func remove_tags(article_id:String, tags:Array)->void:
	Logger.info(name + " - " + "remove_tags({0},{1})".format([article_id, str(tags)]))
	
	var temp_file = save_system.open_file(article_id)
	
	for tag in tags:
		temp_file.tags.remove(temp_file.tags.find(tag))
	
	save_system.save_file(
		temp_file.article_name,
		temp_file.article_id,
		temp_file.banner,
		temp_file.raw_data,
		temp_file.tags
	)

	CommandSystem.API.echo("removed tags {0} from article {1}".format([str(tags), article_id]))


func add_tags(article_id:String, tags:Array)->void:
	Logger.info(name + " - " + "add_tags({0},{1})".format([article_id, tags]))

	var temp_file = save_system.open_file(article_id)

	temp_file.tags.append_array(tags)
	save_system.save_file(
		temp_file.article_name,
		temp_file.article_id,
		temp_file.banner,
		temp_file.raw_data,
		temp_file.tags
	)

	CommandSystem.API.echo("added tags {0} to article {1}".format([str(tags), article_id]))


func get_articles_with_tag(tag_name:String)->Array:
	Logger.info(name + " - " + "get_articles_with_tag({0})".format([tag_name]))
	
	var articles = []
	
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
				var temp_artilce = load(base_folder + "/" + file)
				if temp_artilce.tags.has(tag_name):
					articles.append(temp_artilce)
		folder.list_dir_end()
	
	CommandSystem.API.echo("list of article with tag {0} : {1}".format([tag_name, str(articles)]))
	
	return articles

func get_articles()->Array:
	Logger.info(name + " - " + "get_articles()")
	
	var articles = []
	
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
				var temp_artilce = load(base_folder + "/" + file)
				articles.append(temp_artilce)
		folder.list_dir_end()
	
	CommandSystem.API.echo("list of article : {0}".format([str(articles)]))
	
	return articles
