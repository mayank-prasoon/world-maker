extends Control

signal open_card_reader(card_article)

export(Resource) var article:Resource = Article.new()

func _ready():
	var card_manager = get_parent().get_parent().get_parent().get_node("CardManager")
	var _x = self.connect("open_card_reader", card_manager, "open_card_reader")
	
	$VBoxContainer/Title.text       = article.article_name
	$VBoxContainer/Description.text = article.article_description

func _on_Cards_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			emit_signal("open_card_reader", article)
		
