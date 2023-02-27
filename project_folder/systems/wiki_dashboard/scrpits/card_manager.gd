extends Node

@onready var cards_grid = $"../ScrollContainer/GridContainer"

func get_article(text:String)->void:
	var cards = cards_grid.get_children()

	# hide cards
	if !(cards == []) or !(text == ""):
		for card in cards:
			card.visible = search_card(text, card)

	# displays all cards
	if text == "":
		for card in cards:
			card.visible = filter_card(card)

# the search the cards based checked the text provided
func search_card(text:String, card:Control)->bool:
	var state:bool = false
	
	if text.to_lower() in card.article.article_name.to_lower():
		state = filter_card(card)
	elif text.to_lower() in card.article.article_id.to_lower():
		state = filter_card(card)
	elif card.article.tags.has(text.to_lower()):
		state = filter_card(card)
	else:
		state = false
	
	return state

# filter card based checked the check box ticked
func filter_card(card:Control)->bool:
	var filter = $"../../SearchBar/FilterPopup/Panel/VBoxContainer".get_children()
	
	var state:bool = false
	
	if card.article.article_type == Article.BASIC:
		if filter[Article.BASIC].pressed:
			state = true

	if card.article.article_type == Article.MAP:
		if filter[Article.MAP].pressed:
			state = true

	if card.article.article_type == Article.PIN:
		if filter[Article.PIN].pressed:
			state = true

	return state

# NOTE: currently under developemnt
func open_card_reader(card_article:Resource):
	var reader:PackedScene = load("res://systems/wiki_dashboard/ui_elements/wiki_reader/WikiReader.tscn")
	var x = reader.instantiate()
	x.article = card_article
	get_owner().add_child(x)

func _on_LineEdit_text_changed(new_text):
	get_article(new_text)
