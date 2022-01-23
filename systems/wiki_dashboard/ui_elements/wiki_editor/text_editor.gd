extends Control

# === Node ===

onready var basics_tab:VBoxContainer = $Panel/TabContainer/Basic/VBoxContainer
onready var ui:Node                  = $UIManager

enum ARTICAL_TYPE {
	BASIC,
	MAP,
	PIN
}

func _ready():
	ui.add_text_input(basics_tab, "Article Name", "name of the article")
	
	ui.add_select_file(basics_tab, "Profile", "select a image as a profile")
	ui.add_select_file(basics_tab, "Banner", "choose and image for the banner")
	
	ui.add_dropdown_input(basics_tab, "Article Type", "type of article", ["basic", "map", "pin"])
	ui.add_dropdown_input(basics_tab, "Article Template", "prompt template for article")

	ui.add_description_input(basics_tab,"Description", "short description of the article.\nwill show up in the card")
	
	self.get_node("Panel/TabContainer/Basic/VBoxContainer/Article Type/VBoxContainer/HBoxContainer/OptionButton").connect("item_selected", self, "assign_template")
	self.get_node("Panel/TabContainer/Basic/VBoxContainer/Article Type/VBoxContainer/HBoxContainer/OptionButton").emit_signal("item_selected", 0)

	
func assign_template(id:int)->void:
	var input_drop_down:OptionButton = self.get_node("Panel/TabContainer/Basic/VBoxContainer/Article Template/VBoxContainer/HBoxContainer/OptionButton")
	
	input_drop_down.items = []

	# clean the list
	match id:
		ARTICAL_TYPE.BASIC:
			# get article templates from the project settings singletons
			input_drop_down.add_item("default")
			input_drop_down.add_item("empty")

		ARTICAL_TYPE.MAP:
			input_drop_down.add_item("default")

		ARTICAL_TYPE.PIN:
			input_drop_down.add_item("default")

