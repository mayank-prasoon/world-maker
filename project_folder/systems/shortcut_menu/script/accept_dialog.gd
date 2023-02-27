extends Popup

@export var action_name: String:String  = ''
@export var input: InputEvent:InputEvent

var i:bool = false

func _input(event):
	if (event is InputEventKey):
		if event.is_pressed():
			$ButtonPressed.text = event.as_text()
			input = event
#
func _process(_delta):
	if input == null:
		$Button.disabled = true
	else:
		$Button.disabled = false
	if i:
		self.popup_centered()
	else:
		self.hide()


func _on_Button_pressed():
	i = false
	ProjectSettingsManager.shortcut_settings.remap_input(action_name, input)
	var x = get_tree().get_nodes_in_group("button")
	for y in x:
		if y.action_name == action_name:
			y.get_node("Button").text = input.as_text()

func _on_Button2_pressed():
	i = false
	
