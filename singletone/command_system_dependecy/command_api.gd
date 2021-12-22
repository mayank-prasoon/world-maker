extends Node

# === NODES ===

onready var root            = get_parent()
onready var Console         = $"../CommandSystemInterface/Console/Log"

# === SystemDataManager NODES ===

onready var PIN:Node      = SystemDataManager.get_node("PinSystem")
onready var CHUNK:Node    = SystemDataManager.get_node("MapChunkSystem")
onready var TEMPLATE:Node = SystemDataManager.get_node("SymbolTemplateSystem")
onready var MAP:Node      = SystemDataManager.get_node("MapSystem")
onready var ARTICLE:Node  = SystemDataManager.get_node("ArticleSystem")

# === VERIABLES === 

var Logs:Array = []

func new_pin(pin_name:String):
	var uuid = PIN.make_new_pin(pin_name)
	echo("pin uuid: " + uuid)

func echo(value, pos:int = Label.ALIGN_LEFT):
	var result:String = str(value)
	var output = Label.new()
	output.align = pos
	output.text = result
	Logs.append(result)
	Console.add_child(output)

func clear():
	for x in Console.get_children():
		Console.remove_child(x)

func ls_commands():
	echo("=== LIST OF COMMAND ===", Label.ALIGN_CENTER)
	for x in self.get_method_list():
		echo(x["name"])
	echo("=== END ===", Label.ALIGN_CENTER)
