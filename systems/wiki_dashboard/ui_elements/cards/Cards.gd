extends Control

signal open_card_reader(card_article)

export(Resource) var article:Resource = RootArticle.new()

func _ready():
	var card_manager = get_parent().get_parent().get_parent().get_node("CardManager")
	var _x = self.connect("open_card_reader", card_manager, "open_card_reader")

func _on_Cards_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			emit_signal("open_card_reader", article)
		
