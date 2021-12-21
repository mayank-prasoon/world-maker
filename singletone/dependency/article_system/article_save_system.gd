extends SaveSystem

func _ready():
	save_location = self.root_node.root_save_file_path + '/articles/{uuid}_save_data.tres'
	resource_type = self.root_node.MAP_RESOURCE_TYPE.ARTICLE
	
func save_file(
		article_name:String,
		article_id:String    = root_node.uuid_util.v4(),
		banner:String        = "xyz",
		raw_data:String      = "",
		tags:Array           = []
	) -> void:

	var newArticleData        = root_node.article.new()
	newArticleData.article_name   = article_name
	newArticleData.article_id     = article_id
	newArticleData.banner         = banner
	newArticleData.raw_data       = raw_data
	newArticleData.tags           = tags

	var _x = ResourceSaver.save(
		save_location.format({"uuid": article_id}),
		newArticleData
	)
