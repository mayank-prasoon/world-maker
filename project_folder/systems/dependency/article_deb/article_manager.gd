class_name ArticleManager
extends RefCounted

static func get_tags(article_name:String) -> Array:
	var _temp_article_resource:Resource  = ResourceManager.open_file(article_name, ResourceManager.ARTICLE)
	var tags:Array                       = _temp_article_resource.tags

	CommandSystem.API.echo("list of all the tags: {0}".format([str(tags)]))

	return tags
