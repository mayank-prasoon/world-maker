class_name MapLayer
extends Resource

enum blending_mode {
	normal,
	multiply,
	divide,
	difference,
	add,
	darken,
	burn,
	dodge,
	lighten,
	overlay,
	screen,
	soft_light,
	hard_light,
	custom_shader
}

# basic maths
const normal:int     = 0
const multiply:int   = 1
const divide:int     = 2
const difference:int = 3
const add:int        = 4

# darker
const darken:int     = 5
const burn:int       = 6

# lighter
const dodge:int      = 7
const lighten:int    = 8
const overlay:int    = 9
const screen:int     = 10

# lighting
const soft_light:int = 11
const hard_light:int = 12

# custom_shader
const custom_shader:int = 13

@export var layer_name: String:String                  = ""
@export var layer_path:String                  = "" # (String, FILE)
@export var layer_description:String           = "" # (String, MULTILINE)
@export var layer_visibility: bool                   = false : set = set_layer_visibility
@export var layer_shader: blending_mode:int                   = 0
@export var layer_custom_shader: VisualShader:VisualShader   = VisualShader.new()
@export var layer_opacity:float                = 100.0  # (float, EXP, 0, 100, 1)

static func fetch_shader_material(blend_mode:int, custom_shader_resource:VisualShader)->ShaderMaterial:
	var new_material:ShaderMaterial = ShaderMaterial.new()

	match blend_mode:
		normal:
			new_material.gdshader = null
		multiply:
			new_material.gdshader = load("res://assets/shaders/multiply.tres")
		divide:
			new_material.gdshader = load("res://assets/shaders/divide.tres")
		difference:
			new_material.gdshader = load("res://assets/shaders/difference.tres")
		add:
			new_material.gdshader = load("res://assets/shaders/add.tres")

		darken:
			new_material.gdshader = load("res://assets/shaders/darken.tres")
		burn:
			new_material.gdshader = load("res://assets/shaders/burn.tres")

		dodge:
			new_material.gdshader = load("res://assets/shaders/dodge.tres")
		lighten:
			new_material.gdshader = load("res://assets/shaders/lighten.tres")
		overlay:
			new_material.gdshader = load("res://assets/shaders/overlay.tres")
		screen:
			new_material.gdshader = load("res://assets/shaders/screen.tres")
		soft_light:
			new_material.gdshader = load("res://assets/shaders/soft_light.tres")
		hard_light:
			new_material.gdshader = load("res://assets/shaders/hard_light.tres")
		custom_shader:
			new_material.gdshader = custom_shader_resource

	return new_material

func set_layer_visibility(value:int)->void:
	layer_visibility = value
