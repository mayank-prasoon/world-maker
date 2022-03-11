class_name PresetInputManager
extends Reference

# move to system data manager
const TEXT          = 0
const BIG_TEXT      = 1
const IMAGE         = 2
const DROPDOWN      = 3
const SPINBOX       = 4
const TOGGLE_BUTTON = 5
const CHECKBOX      = 6
const DATABASE      = 7

static func load_prompt(node, template:Resource)->void:
	for x in template.template_prompts:
		var item:RootFieldInput = RootFieldInput.new()

		match x["type"]:
			TEXT:
				item = load("res://systems/dependency/ui_elements/input_text/InputText.tscn").instance()

			BIG_TEXT:
				item = load("res://systems/dependency/ui_elements/input_large_text/InputLargeText.tscn").instance()

			IMAGE:
				item = load("res://systems/dependency/ui_elements/input_large_text/InputLargeText.tscn").instance()

			DROPDOWN:
				item = load("res://systems/dependency/ui_elements/input_dropdown/InputDropDown.tscn").instance()

				item.input_dropdown_option = x["input_dropdown_option"]

			SPINBOX:
				item = load("res://systems/dependency/ui_elements/input_spin_box/InputSpinBox.tscn").instance()

				if x.keys().has("input_spin_box_prefix"):
					item.input_spin_box_prefix = x["input_spin_box_prefix"]
				if x.keys().has("input_spin_box_suffix"):
					item.input_spin_box_suffix = x["input_spin_box_suffix"]

			TOGGLE_BUTTON:
				item = load("res://systems/dependency/ui_elements/input_toggle_button/InputToggleButton.tscn").instance()
				
				if x.keys().has('input_value_if_true'):
					item.input_value_if_true  = x['input_value_if_true']
				if x.keys().has('input_value_if_false'):
					item.input_value_if_false = x['input_value_if_false'] 


			CHECKBOX:
				item = load("res://systems/dependency/ui_elements/input_check_box/InputCheckBox.tscn").instance()


			DATABASE:
				item = load("res://systems/dependency/ui_elements/input_relatabe_database/InputRelatableDatabase.tscn").instance()

		
		item.input_name               = x["name"]
		item.input_display            = x["display"]
		
		if x.keys().has('value'):
			item.input_value              = x["value"]
		if x.keys().has('description'):
			item.input_description        = x["description"]
		if x.keys().has('null_value'):
			item.input_null_display_value = x["null_value"]
		
		node.add_child(item)
