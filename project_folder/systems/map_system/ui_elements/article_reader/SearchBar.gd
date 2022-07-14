extends Control


# the search the cards based on the text provided
func search_card(text:String, pin:Control)->bool:
	var state:bool = false

	if text.to_lower() in pin.map_pin_resource.pin_name.to_lower():
		state = true
	elif text.to_lower() in pin.map_pin_resource.pin_id.to_lower():
		state = true
	elif pin.map_pin_resource.tags.has(text.to_lower()):
		state = true
	else:
		state = false

	return state

func _on_LineEdit_text_changed(new_text):
	var self_owner = $"../ScrollContainer/Panel/VBoxContainer2/VBoxContainer"

	if self_owner.get_children() != null:
		for pin_node in self_owner.get_children():
			pin_node.visible = true
			pin_node.visible = search_card(new_text, pin_node)

	if new_text == "":
		if self_owner.get_children() != null:
			for pin_node in self_owner.get_children():
				pin_node.visible = true

