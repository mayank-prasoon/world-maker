class_name RootArticle
extends Resource

export(String)         var article_name:String
export(String)         var article_id:String
export(String, FILE)   var article_profile:String
export(String, FILE)   var article_banner:String
export(Resource)       var article_prompts:Resource
export(String)         var article_raw_data:String
export(Array, String)  var tags:Array
