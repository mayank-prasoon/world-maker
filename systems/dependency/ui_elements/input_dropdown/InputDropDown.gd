extends RootFieldInput

#export(int)    var input_value:int              = 0
export(Array)  var input_dropdown_option:Array  = [""]

onready var drop_down_menu:OptionButton = $VBoxContainer/HBoxContainer/OptionButton

func _ready()->void:
	$VBoxContainer/Label.text = input_name

	for x in input_dropdown_option:
		drop_down_menu.add_item(x)

	if !(input_value is int):
		input_value = 0

	drop_down_menu.selected = input_value

func dispaly()->String:
	var value:String = drop_down_menu.get_item_text(input_value)
	return input_display.format({'value': value})


func _on_OptionButton_item_selected(index):
	set_input_value(index)
