extends Control

var wiki_editor:PackedScene    = load("res://systems/wiki_dashboard/ui_elements/wiki_editor/WikiEditor.tscn")

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

	# connect signals
	var _x = EventBus.connect("edit_article", self, 'edit_article')

func edit_article(article):
	var node = wiki_editor.instance()
	get_parent().get_owner().editor_layer.add_child(node)
	node.open_article(article)
	self.queue_free()


func _on_Button_pressed():
	var node = wiki_editor.instance()
	get_parent().get_owner().editor_layer.add_child(node)
	self.queue_free()

