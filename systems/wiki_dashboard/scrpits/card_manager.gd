extends Node

# node
onready var cards_grid:GridContainer = $"../ScrollContainer/GridContainer"
onready var article_list:Array = SystemDataManager.get_node("ArticleSystem").get_articles()

# const
const CARDS_TEMP = preload("res://systems/wiki_dashboard/UI_elements/cards/Cards.tscn")

func _ready():
	for article in article_list:
		var cards = CARDS_TEMP.new()
		cards.article = article
		cards_grid.add_child(cards)

func _on_AddNewCardButton_pressed():
	pass # Replace with function body.

func get_article(text:String)->void:
	for card in cards_grid.get_children():
		if text in card.article.article_name:
			card.visible = true
		elif text in card.article.article_id:
			card.visible = true
		elif card.article.tags.has(text):
			card.visible = true
		else:
			card.visible = false
