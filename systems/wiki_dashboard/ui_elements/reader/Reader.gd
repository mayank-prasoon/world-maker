extends Control

signal open_wiki_editor(article)

onready var rich_text    = $Panel/VBoxContainer/Control/VBoxContainer/RichTextLabel

var article:Article      = Article.new()
var texture:ImageTexture

func _ready():
	rich_text.bbcode_enabled = true
	load_preview()
	texture = ImageHandler.load_image_texture(article.article_banner)
	asign_banner()
	var _x = self.connect("open_wiki_editor", self.get_parent().get_owner(), 'edit_article')
	
func load_preview():
	$Panel/VBoxContainer/Control/VBoxContainer/RichTextLabel.bbcode_text = article.article_raw
	$Panel/VBoxContainer/Control/VBoxContainer/Title.text                = article.article_name
	
func asign_banner():
	var size = $Panel/VBoxContainer/TextureRect.get_rect()

	var atlas = AtlasTexture.new()
	atlas.set_atlas(texture)
	atlas.set_region(
		Rect2(
			size
		)
	)

	$Panel/VBoxContainer/TextureRect.texture = atlas



func _on_CloseButton_pressed():
	self.queue_free()

func _on_Button_pressed():
	emit_signal("open_wiki_editor", article)

func _on_TextureRect_resized():
	asign_banner()
