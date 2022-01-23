class_name RootArticle
extends Resource

export(String)         var article_name:String
export(String)         var article_id:String
export(String, FILE)   var article_profile:String
export(String, FILE)   var article_banner:String

export(int)            var article_type:int
export(Resource)       var article_template:Resource

export(String)         var article_raw:String

export(Array, String)  var tags:Array
