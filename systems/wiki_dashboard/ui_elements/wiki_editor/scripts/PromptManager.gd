extends Node

# move to system data manager
enum template_value_type {
	text,
	big_text,
	image,
	big_picture,
	dropdown,
	spinbox,
	toggle_button,
	checkbox,
	related_database,
	unrelated_database
}

func _ready():
	pass

func _load_prompt(template:Resource):
	for x in template:
		var input_scene

		match x["type"]:
			template_value_type.text:
				pass

		x["name"]
		x["value"]
