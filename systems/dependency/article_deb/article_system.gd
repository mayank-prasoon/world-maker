class_name ArticleSystem
extends Reference

# creats new article with new uuid
static func make_new_article(
		article_name:String,
		profile:String            = "xyz",
		banner:String             = "xyz",
		article_type:int          = 0,
		article_template:Resource = Resource.new(),
		note:String              = "",
		raw_data:String           = "",
		description               = "",
		tags:Array                = []
	)->String:

	var uuid = UUID.generate()

	ResourceManager.save_file(
		{
			'article_name'        : article_name,
			'article_id'          : uuid,
			'article_profile'     : profile,
			'article_banner'      : banner,
			'article_type'        : article_type,
			'article_template'    : article_template,
			'article_notes'       : note,
			'article_raw'         : raw_data,
			'article_description' : description,
			'tags'                : tags
		},

		ResourceManager.ARTICLE
	)

	CommandSystem.API.echo("new article generated")

	return uuid

# remove tags from the article
static func remove_tags(article_id:String, tags:Array)->void:
	var temp_file = ResourceManager.open_file(article_id, ResourceManager.ARTICLE)
	
	for tag in tags:
		temp_file.tags.remove(temp_file.tags.find(tag))
	
	ResourceManager.save_file(
		{
			'article_name'        : temp_file.article_name,
			'article_id'          : temp_file.article_id,
			'article_profile'     : temp_file.article_profile,
			'article_banner'      : temp_file.article_banner,
			'article_type'        : temp_file.article_type,
			'article_template'    : temp_file.article_template,
			'article_notes'        : temp_file.article_notes,
			'article_raw'         : temp_file.article_raw,
			'article_description' : temp_file.article_description,
			'tags'                : temp_file.tags
		},

		ResourceManager.ARTICLE
	)

	CommandSystem.API.echo("removed tags {0} from article {1}".format([str(tags), article_id]))

# add tag to article
static func add_tags(article_id:String, tags:Array)->void:
	var temp_file = ResourceManager.open_file(article_id, ResourceManager.ARTICLE)

	temp_file.tags.append_array(tags)

	ResourceManager.save_file(
		{
			'article_name'        : temp_file.article_name,
			'article_id'          : temp_file.article_id,
			'article_profile'     : temp_file.article_profile,
			'article_banner'      : temp_file.article_banner,
			'article_type'        : temp_file.article_type,
			'article_template'    : temp_file.article_template,
			'article_notes'        : temp_file.article_notes,
			'article_raw'         : temp_file.article_raw,
			'article_description' : temp_file.article_description,
			'tags'                : temp_file.tags
		},

		ResourceManager.ARTICLE
	)

	CommandSystem.API.echo("added tags {0} to article {1}".format([str(tags), article_id]))

# 
static func get_articles_with_tag(tag_name:String)->Array:
	var base_folder = SystemDataManager.root_article_save_path.get_base_dir()
	
	var articles:Array     = FolderManager.fetch_files_from(base_folder, true)
	
	var temp_article:Array = []
	
	for i in range(articles.size()):
		if load(articles[i]).tags.has(tag_name):
			temp_article.append(load(articles[i]))
	
	CommandSystem.API.echo("list of article with tag {0} : {1}".format([tag_name, str(articles)]))
	
	return temp_article

# get array of articles
static func get_articles()->Array:
	var base_folder = SystemDataManager.root_article_save_path.get_base_dir()
	
	var articles = FolderManager.fetch_files_from(base_folder)
	CommandSystem.API.echo("list of article : {0}".format([str(articles)]))
	
	return articles
