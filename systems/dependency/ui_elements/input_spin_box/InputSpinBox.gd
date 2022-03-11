extends RootFieldInput

#export(int)    var input_value:int              = 0
export(String) var input_spin_box_prefix:String = "" 
export(String) var input_spin_box_suffix:String = ""

func _ready()->void:
	$VBoxContainer/Label.text                   = input_name
	$VBoxContainer/HBoxContainer/SpinBox.prefix = input_spin_box_prefix
	$VBoxContainer/HBoxContainer/SpinBox.suffix = input_spin_box_suffix


func display()->String:
	if !(input_spin_box_prefix == ""):
		input_spin_box_prefix = input_spin_box_prefix + " "
	
	if !(input_spin_box_suffix == ""):
		input_spin_box_suffix = " " + input_spin_box_suffix 

	return input_display.format({'value' : input_spin_box_prefix + str(input_value) + input_spin_box_suffix})


func _on_SpinBox_value_changed(value):
	set_input_value(value)
