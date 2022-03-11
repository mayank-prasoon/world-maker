extends RootFieldInput

#export(int)    var input_value:bool = false
export(String) var input_value_if_true:String  = ''
export(String) var input_value_if_false:String = ''


func _ready():
	$HBoxContainer/Label.text                   = input_name	
	$HBoxContainer/SpinBox.pressed = input_value

func display():
	var value = ""
	
	if input_value:
		value = input_value_if_true 
	else:
		value = input_value_if_false 

	return input_display.format({'value' : value}) 


func _on_SpinBox_toggled(button_pressed):
	set_input_value(button_pressed)
