class_name ProjectButton
extends HBoxContainer

var fav:bool            = false
var project_name:String = ""
var path:String         = ""

func _ready():
	self.add_constant_override("separation", 20)
	self.grow_horizontal = Control.GROW_DIRECTION_BOTH 

	var label   = Label.new()
	label.text  = path

	var p_name  = Label.new()
	p_name.text = project_name

	var open    = Button.new() 
	open.text   = "open"

	self.add_child(label)
	self.add_child(p_name)
	self.add_child(open)

	open.connect("pressed", self, "open_project")

func open_project():
	SystemSettings.current_path             = path
	ProjectSettingsManager.open_project()
	var _x = get_tree().change_scene_to(load("res://systems/system_menu/SystemMenu.tscn"))
