extends SaveSystem

func _ready()->void:
	Logger.info(name + " - node loaded")
	save_location = self.root_node.root_save_file_path + '/articles/{uuid}_save_data.tres'
	resource_type = self.root_node.MAP_RESOURCE_TYPE.ARTICLE
	
func save_file(
	article_name:String,
	article_id:String         = root_node.uuid_util.v4(),
	profile:String            = "xyz",
	banner:String             = "xyz",
	article_type:int          = 0,
	article_template:Resource = Resource.new(),
	raw_data:String           = "",
	tags:Array                = []
	) -> void:
	
	Logger.info(name + " - " + "save_file({0},{1},{2},{3},{5})".format([article_name, article_id, banner, raw_data, str(tags)]))

	var newArticleData              = Article.new()
	newArticleData.article_name     = article_name
	newArticleData.article_id       = article_id
	newArticleData.article_profile  = profile
	newArticleData.article_banner   = banner
	newArticleData.article_type     = article_type
	newArticleData.article_template = article_template
	newArticleData.article_raw      = raw_data
	newArticleData.tags             = tags

	var _x = ResourceSaver.save(
		save_location.format({"uuid": article_id}),
		newArticleData
	)

	CommandSystem.API.echo("article saved:")
	CommandSystem.API.echo(save_location.format({"uuid": article_id}))
