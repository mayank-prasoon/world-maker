extends Control

signal open_card_reader(card_article)

export(Resource) var article:Resource = Article.new()

onready var title_node:Label         = $TextureRect/CenterContainer/Background/VBoxContainer/VBoxContainer/Title
onready var description_node:Label   = $TextureRect/CenterContainer/Background/VBoxContainer/VBoxContainer/Description
onready var profile_node:TextureRect = $TextureRect/CenterContainer/Background/VBoxContainer/TextureRect

func _ready():
	add_to_group("cards")
	var card_manager = get_parent().get_parent().get_parent().get_node("CardManager")
	var _x = self.connect("open_card_reader", card_manager, "open_card_reader")
	
	if !(article.article_profile == ""):
		profile_node.texture  = ImageHandler.load_image_texture(article.article_profile)
	
	title_node.text       = article.article_name
	description_node.text = article.article_description

var fliped = false

func _on_Background_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_MASK_LEFT and event.doubleclick:
			emit_signal("open_card_reader", article)
		if event.button_index == BUTTON_MASK_RIGHT and event.pressed:
			$TextureRect/CenterContainer/Background.grab_focus()
			if fliped == false:
				$TextureRect/CenterContainer/Background/AnimationPlayer.play("flip")
				fliped = true
			elif fliped == true:
				$TextureRect/CenterContainer/Background/AnimationPlayer.play_backwards("flip")
				fliped = false

		if event.button_index == BUTTON_MASK_LEFT and event.pressed:
			if fliped == true:
				$TextureRect/CenterContainer/Background/AnimationPlayer.play_backwards("flip")
				fliped = false

	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ENTER:
			emit_signal("open_card_reader", article)
	
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_SPACE:
			if fliped == false:
				$TextureRect/CenterContainer/Background/AnimationPlayer.play("flip")
				fliped = true
			elif fliped == true:
				$TextureRect/CenterContainer/Background/AnimationPlayer.play_backwards("flip")
				fliped = false

func _input(event):
	if event is InputEventMouseButton:	
		if event.button_index == BUTTON_MASK_RIGHT and event.doubleclick:
			get_tree().call_group("cards", 'unflip')

func unflip():
	if fliped == true:
		$TextureRect/CenterContainer/Background/AnimationPlayer.play_backwards("flip")
		fliped = false


func _on_Delete_pressed():
	var dir:Directory = Directory.new()
	dir.remove(article.get_path())
	self.queue_free()
