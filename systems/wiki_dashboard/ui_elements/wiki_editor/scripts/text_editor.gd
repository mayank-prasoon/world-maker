extends Control

# === Node ===

onready var basics_tab:VBoxContainer = $Panel/TabContainer/Basic/ScrollContainer/VBoxContainer

var prompts:Array = [
	{
		'name': '',
		'path': ''
	}
]


func _ready():
	UIManager.add_text_input(basics_tab, "Article Name", "name of the article")
	UIManager.add_select_file(basics_tab, "Profile", "select a image as a profile")
	UIManager.add_select_file(basics_tab, "Banner", "choose and image for the banner")
	UIManager.add_dropdown_input(basics_tab, "Article Type", "type of article", ["basic", "map", "pin" ])
	UIManager.add_dropdown_input(basics_tab, "Article Template", "prompt template for article")
	UIManager.add_text_input(basics_tab, "Article Tag", "add tag.\nSeprate the Tags by (',')")
	UIManager.add_description_input(basics_tab, "Description", "short description of the article.\nwill show up in the card")
	
	var _x = basics_tab.get_node("Article Type/VBoxContainer/HBoxContainer/OptionButton").connect("item_selected", self, "assign_template")
	basics_tab.get_node("Article Type/VBoxContainer/HBoxContainer/OptionButton").emit_signal("item_selected", 0)
	
	var _y = basics_tab.get_node("Article Template/VBoxContainer/HBoxContainer/OptionButton").connect("item_selected", self, "assign_prompts")
	basics_tab.get_node("Article Template/VBoxContainer/HBoxContainer/OptionButton").emit_signal("item_selected", 0)


# assin template
func assign_template(id:int)->void:
	var input_drop_down:OptionButton = self.get_node("Panel/TabContainer/Basic/ScrollContainer/VBoxContainer/Article Template/VBoxContainer/HBoxContainer/OptionButton")
	
	var templates:Array = FolderManager.fetch_files_from(SystemDataManager.root_temp_save_path.get_base_dir(), true)

	# clean the list
	input_drop_down.items = []
	prompts               = []
	
	match id:
		Article.BASIC:
			# get article templates from the project settings singletons
			input_drop_down.add_item("empty")

		Article.MAP:
			input_drop_down.add_item("empty")

		Article.PIN:
			input_drop_down.add_item("empty")
	
	prompts.append(
		{
			'name' : 'empty',
			'type' : id,
			'path' : ''
		}
	)

	for x in templates:
		var template = load(x).new()
		if (template.template_type == id):
			input_drop_down.add_item(template.template_name)
			prompts.append(
				{
					'name' : template.template_name,
					'type' : template.template_type,
					'path' : x
				}
			)
		else:
			pass

	input_drop_down.emit_signal("item_selected", 0)

# assign promts
func assign_prompts(id:int):
	var pannel_container = $Panel/TabContainer/Prompts/ScrollContainer/VBoxContainer
	for i in pannel_container.get_children():
		i.free()

	var path = prompts[id]['path']
	if !(path == ''):
		PresetInputManager.load_prompt(
			pannel_container,
			load(path).new()
		)

		get_owner().article_template = load(path).new()
		get_owner().connect_nodes()

	else:
		get_owner().article_template = Resource.new()
