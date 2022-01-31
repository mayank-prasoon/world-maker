extends Node

# node
onready var cards_grid:GridContainer = $"../ScrollContainer/GridContainer"
onready var article_list:Array = SystemDataManager.get_node("ArticleSystem").get_articles()

# const
const CARDS_TEMP = preload("res://systems/wiki_dashboard/ui_elements/cards/Cards.tscn")

func _ready():
	for article in article_list:
		var cards = CARDS_TEMP.new()
		cards.article = article
		cards_grid.add_child(cards)

func get_article(text:String)->void:
	var cards = cards_grid.get_children()
	
	# hide cards
	if (cards != []) or (text != ""):
		for card in cards:
			if text in card.article.article_name:
				card.visible = true
			elif text in card.article.article_id:
				card.visible = true
			elif card.article.tags.has(text):
				card.visible = true
			else:
				card.visible = false
	
	# displays all cards
	if text == "":
		for card in cards:
			card.visible = true

# NOTE: currently under developemnt
func open_card_reader(card_article):
	var reader:PackedScene = load("res://systems/wiki_dashboard/ui_elements/reader/Reader.tscn")
	get_parent().add_child(reader.instance())


func _on_AddNewCardButton_pressed():
	pass

func _on_LineEdit_text_changed(new_text):
	get_article(new_text)
