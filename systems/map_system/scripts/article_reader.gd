extends Control

onready var banner_node:TextureRect  = $Panel/VBoxContainer/Container/ScrollContainer/VBoxContainer/TextureRect
onready var profile_node:TextureRect = $Panel/VBoxContainer/CloseBar/HBoxContainer/TextureRect
onready var raw_text:RichTextLabel   = $Panel/VBoxContainer/Container/ScrollContainer/VBoxContainer/RichTextLabel
onready var title_node:Label         = $Panel/VBoxContainer/CloseBar/HBoxContainer/Label

enum TOGGLE_STATE {
	OPEN,
	CLOSE
}

var state   = TOGGLE_STATE.CLOSE
var resource = null

func _ready()->void:
	self.hide()
	add_to_group("article_viewer")
	var _x = EventBus.connect("open_article_panel", self, '_on_open_panel')
	var _y = EventBus.connect("close_article_panel", self, '_on_close_panel')


# button pressed button method
func _on_close_panel()->void:
	state = TOGGLE_STATE.CLOSE
	self.hide()


# open article signal method
func _on_open_panel(article:Article)->void:
	if !(article == null or article.article_id == null or article.article_id == ""): 
		if TOGGLE_STATE.OPEN != state: 
			state = TOGGLE_STATE.OPEN
			load_article(article)
			self.show()


# load article signal method
func load_article(article:Article)->void:
	resource = article

	var file = File.new()
	if !(article.article_banner == "") or file.file_exists(article.article_banner):
		banner_node.visible = true
		banner_node.texture = ImageHandler.load_image_texture(article.article_banner)
	else:
		banner_node.visible = false
	
	if !(article.article_profile == "") or file.file_exists(article.article_profile):
		profile_node.visible = true
		profile_node.texture = ImageHandler.load_image_texture(article.article_profile)
	else:
		profile_node.visible = false

	raw_text.bbcode_text = article.article_raw
	title_node.text      = article.article_name
	
	
func _on_Button_pressed():
	EventBus.emit_signal("close_article_panel")

# implement feature
func _on_expand_pressed():
	EventBus.emit_signal("edit_article", resource)
