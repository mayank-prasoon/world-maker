extends Control

# node
onready var cards_grid:GridContainer = $VBoxContainer/CardList/ScrollContainer/GridContainer

# const
const CARDS_TEMP = preload("res://systems/wiki_dashboard/ui_elements/cards/Cards.tscn")

func _ready():
	var path:String = SystemDataManager.root_article_save_path

	for article in FolderManager.fetch_files_from(path.get_base_dir()):
		if !article == null:
			var cards = CARDS_TEMP.instance()
			cards.article = article
			cards_grid.add_child(cards)


func _on_Button_pressed():
	EventBus.emit_signal("create_article")
