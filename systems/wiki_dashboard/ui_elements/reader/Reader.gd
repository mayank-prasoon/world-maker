extends Control

signal open_wiki_editor(article)

onready var rich_text_node    = $CanvasLayer/Panel/ScrollContainer/VBoxContainer/HBoxContainer/VBoxContainer/RichTextLabel
onready var title_text_node   = $CanvasLayer/Panel/ScrollContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Title
onready var article_profile   = $CanvasLayer/Panel/ScrollContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/TextureRect

var article:Article      = Article.new()
var texture:ImageTexture


func _ready():
	$AnimationPlayer.play("open")
	rich_text_node.bbcode_enabled = true
	load_preview()
	texture = ImageHandler.load_image_texture(article.article_banner)
	if !(article.article_profile == ""):
		article_profile.texture = ImageHandler.load_image_texture(article.article_profile)
	asign_banner()


func load_preview():
	rich_text_node.bbcode_text = article.article_raw
	title_text_node.text                = article.article_name


func asign_banner():
	var banner_image_node:TextureRect = $CanvasLayer/Panel/ScrollContainer/VBoxContainer/TextureRect

#	var size = banner_image_node.get_rect()

#	var atlas = AtlasTexture.new()
#	atlas.set_atlas(texture)
#	atlas.set_region(
#		Rect2(
#			size
#		)
#	)
#	var position = (466.001/2.0001)/float(texture.get_height())
#	print(position)
##
#	banner_image_node.material.set_shader_param("position", position)
	banner_image_node.texture = texture


func _on_CloseButton_pressed():
	$AnimationPlayer.play("close")


func _on_Button_pressed():
	EventBus.emit_signal("edit_article", article)


func _on_TextureRect_resized():
	asign_banner()
