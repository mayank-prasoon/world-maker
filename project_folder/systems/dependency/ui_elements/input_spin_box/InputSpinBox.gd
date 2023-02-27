extends RootFieldInput

#export var input_value: int:int              = 0
@export var input_spin_box_prefix: String:String = "" 
@export var input_spin_box_suffix: String:String = ""

func _ready()->void:
	$VBoxContainer/Label.text                   = input_name
	$VBoxContainer/HBoxContainer/SpinBox.prefix = input_spin_box_prefix
	$VBoxContainer/HBoxContainer/SpinBox.suffix = input_spin_box_suffix


func display()->String:
	if !(str(input_value) == '0' or str(input_value) == ''):
		var value:String = str(input_value)
		if !(input_spin_box_prefix == ""):
			value = input_spin_box_prefix + " " + str(input_value)
		
		if !(input_spin_box_suffix == ""):
			value = str(input_value) + " " + input_spin_box_suffix 

		return input_display.format({'value' : value})
	else:
		return input_display.format({'value' : input_null_display_value})

func _on_SpinBox_value_changed(value):
	set_input_value(value)
