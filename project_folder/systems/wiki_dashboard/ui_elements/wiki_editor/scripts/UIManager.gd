class_name UIManager
extends Reference

static func add_text_input(
		node:VBoxContainer,
		input_name:String,
		input_des:String,
		input_value:String = ""
	)->void:
	
	var input_ui:Control       = load("res://systems/dependency/ui_elements/input_text/InputText.tscn").instance()
	input_ui.name              = input_name

	input_ui.input_name        = input_name
	input_ui.input_description = input_des
	input_ui.input_value       = input_value

	node.add_child(input_ui)

static func add_select_file(
		node:VBoxContainer,
		input_name:String,
		input_des:String,
		input_value:String = ""
	)->void:
	
	var input_ui:Control       = load("res://systems/dependency/ui_elements/input_open_file/InputOpenFile.tscn").instance()
	input_ui.name              = input_name

	input_ui.input_name        = input_name
	input_ui.input_description = input_des
	input_ui.input_value       = input_value
	
	node.add_child(input_ui)

static func add_dropdown_input(
		node:VBoxContainer,
		input_name:String,
		input_des:String,
		input_options:Array = [],
		input_value:int = 0,
		disabled:bool   = false
	)->void:
	
	var input_ui:Control           = load("res://systems/dependency/ui_elements/input_dropdown/InputDropDown.tscn").instance()
	input_ui.name                  = input_name

	input_ui.input_name            = input_name
	input_ui.input_description     = input_des
	input_ui.input_value           = input_value
	input_ui.input_dropdown_option = input_options

	var drop_down:OptionButton     = input_ui.get_node("VBoxContainer/HBoxContainer/OptionButton")
	drop_down.disabled             = disabled
	
	node.add_child(input_ui)

static func add_description_input(
		node:VBoxContainer,
		input_name:String,
		input_des:String,
		input_value:String = ""
	)->void:

	var input_ui:Control       = load("res://systems/dependency/ui_elements/input_large_text/InputLargeText.tscn").instance()
	input_ui.name              = input_name
	
	input_ui.input_name        = input_name
	input_ui.input_description = input_des
	input_ui.input_value       = input_value
	
	node.add_child(input_ui)
