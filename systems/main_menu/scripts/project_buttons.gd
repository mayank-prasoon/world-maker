class_name ProjectButton
extends HBoxContainer

var fav:bool            = false
var project_name:String = ""
var path:String         = ""

func _ready():
	self.add_constant_override("separation", 20)
	self.set_h_size_flags(Control.SIZE_EXPAND_FILL)

	var label   = Label.new()
	label.text  = path
	
	var p_name   = Label.new()
	p_name.text  = project_name
	p_name.align = Label.ALIGN_CENTER

	p_name.set_h_size_flags(Control.SIZE_EXPAND_FILL)

	var open    = Button.new()
	open.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	open.text   = "open"

	self.add_child(label)
	self.add_child(p_name)
	self.add_child(open)

	open.connect("pressed", self, "open_project")

func open_project():
	SystemSettings.current_path             = path
	ProjectSettingsManager.open_project()
	var _x = get_tree().change_scene_to(load("res://systems/system_menu/SystemMenu.tscn"))
