extends Control

# === signals ===
signal data_changed


# === nodes ===

onready var basic_tab        = $HBoxContainer/Panel/HSplitContainer/TextEditor/Panel/TabContainer/Basic/ScrollContainer/VBoxContainer
onready var prompt_container = $HBoxContainer/Panel/HSplitContainer/TextEditor/Panel/TabContainer/Prompts/ScrollContainer/VBoxContainer
onready var notes            = $HBoxContainer/Panel/HSplitContainer/TextEditor/Panel/TabContainer/Notes/VBoxContainer/TextEdit
onready var basics_tab       = $HBoxContainer/Panel/HSplitContainer/TextEditor/Panel/TabContainer/Basic/ScrollContainer/VBoxContainer

# === properties ===

var wiki_dashboard:PackedScene = load("res://systems/wiki_dashboard/WikiDashboard.tscn")

var article_template:Resource
var uuid:String                = UUID.generate()
var changes                    = false
var article_resource_file:Resource


func _ready():
	connect_nodes()

# open article and assign values
func open_article(resources:Article)->void:
	for x in basics_tab.get_children():
		x.free()
	
	uuid = resources.article_id
	
	article_template      = resources.article_template
	article_resource_file = load(resources.article_resources)
	
	UIManager.add_text_input(basics_tab, "Article Name", "name of the article", resources.article_name)
	UIManager.add_select_file(basics_tab, "Profile", "select a image as a profile", resources.article_profile)
	UIManager.add_select_file(basics_tab, "Banner", "choose and image for the banner", resources.article_banner)
	UIManager.add_dropdown_input(basics_tab, "Article Type", "type of article", [Article.get_type_name(resources.article_type)], 0, true)
	
	if !(resources.article_template == null or resources.article_template.get('template_name') == null):
		UIManager.add_dropdown_input(basics_tab, "Article Template", "prompt template for article", [resources.article_template.template_name], 0, true)
		PresetInputManager.load_prompt(prompt_container, resources.article_template)
	else:
		UIManager.add_dropdown_input(basics_tab, "Article Template", "prompt template for article", ["empty"], 0, true)

	UIManager.add_text_input(basics_tab, "Article Tag", "add tag.\nSeprate the Tags by (',') no space", PoolStringArray(resources.tags).join(','))
	notes.text = resources.article_notes
	UIManager.add_description_input(basics_tab, "Description", "short description of the article.\nwill show up in the card", resources.article_description)

	connect_nodes()
	emit_signal("data_changed")

# fetch the prompts and notes and generate a raw data
func fetch_raw_data()->String:
	var raw_data:String = ""

	var nodes:Array = prompt_container.get_children()
	var group:Array = get_tree().get_nodes_in_group('input_field')

	for prompts in nodes:
		if group.has(prompts):
			if !(prompts.display() == '' or prompts.display() == ' ' or prompts.display() == '\n' or prompts.display() == ' \n'):
				raw_data += prompts.display()
				raw_data += ' '

	raw_data += notes.get_text()
	return raw_data

# check for changes
func check_change()->void:
	# updates the preview
	changes = true
	emit_signal("data_changed")

# connect the nodes in the group input_field
func connect_nodes()->void:
	for x in get_tree().get_nodes_in_group("input_field"):
		var node:RootFieldInput = x
		if !(node.is_connected("input_value_changed", self, "check_change")):
			var _x = node.connect("input_value_changed", self, "check_change")

# save the data
func _on_Button_pressed()->void:
	var value = null
	if !article_template == null:
		value = article_template
	else:
		value = null

	var index = 0
	for x in prompt_container.get_children():
		value.template_prompts[index]['value'] = x.input_value
		index += 1
	
	var tags = basic_tab.get_node("Article Tag").input_value.split(',')

	ResourceManager.save_file(
		{
			'article_name'        : basic_tab.get_node("Article Name").input_value,
			'article_id'          : uuid,
			'article_profile'     : basic_tab.get_node("Profile").input_value,
			'article_banner'      : basic_tab.get_node("Banner").input_value,
			'article_type'        : basic_tab.get_node("Article Type").input_value,
			'article_template'    : value,
			'article_notes'       : notes.text,
			'article_raw'         : fetch_raw_data(),
			'article_description' : basic_tab.get_node("Description").input_value,
			'tags'                : tags
		},

		ResourceManager.ARTICLE
	)

	changes = false

# close button signal reciver
func _on_Close_pressed()->void:
	if changes: # open a warning popup
		var pop_up:ConfirmationDialog = ConfirmationDialog.new()
		pop_up.set_text('All the filled data will be LOST\n\nAre you sure you want to close')
		pop_up.get_child(1).align = Label.ALIGN_CENTER
		pop_up.set_autowrap(true)
		pop_up.set_title('WARNING')
		pop_up.rect_size = Vector2(200, 100)
		
		var _x = pop_up.connect("confirmed", self, 'close')

		self.add_child(pop_up)
		pop_up.popup_centered()
	else:     # close the window
		close()


func close():
	EventBus.emit_signal("load_wiki_dashboard")
	self.queue_free()


func _on_TextEdit_text_changed():
	emit_signal("data_changed")
