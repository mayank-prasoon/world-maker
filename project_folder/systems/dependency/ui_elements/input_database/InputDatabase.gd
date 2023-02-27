extends RootFieldInput

#signal add_item(item_name)
#signal remove_item(item_name)

@onready var line_edit:LineEdit = $VBoxContainer/HBoxContainer/LineEdit
@onready var itemlist:ItemList  = $VBoxContainer/ItemList

var selected_item

func _ready():
	$VBoxContainer/Label.text = input_name
	
	if !(input_script == ''):
		for item in input_value:
			itemlist.add_item(item)
	else:
		script_object = load(input_script)

# return the parse prompts
func display() -> String:
	var text_collection:Array = []
	var value:String          = ""
	
	for text in itemlist.items:
		if text is String:
			text_collection.append(str(text))
			text_collection.append(', ')

	if !(text_collection.size() == 0):
		text_collection.pop_back()
		if text_collection.size() >= 3:
			text_collection[-2] = " and "

		for x in text_collection:
			value += x
	else:
		value = input_null_display_value

	return input_display.format({'value' : value})

func _on_Remove_pressed():
	if !(selected_item == null):
		itemlist.remove_item(selected_item)
		emit_signal("input_value_changed")
#		emit_signal("remove_item", line_edit.get_text())

func _on_ItemList_item_selected(index):
	selected_item = index

func _on_Add_pressed():
	if !(line_edit.get_text() == ""):
		itemlist.add_item(line_edit.get_text())
		line_edit.clear()
		emit_signal("input_value_changed")
#		emit_signal("add_item", line_edit.get_text())
