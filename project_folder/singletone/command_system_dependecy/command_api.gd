extends Node

# === NODES ===

@onready var root            = get_parent()
@onready var Console         = $"../CanvasLayer/CommandSystemInterface/Console/Log"

# === SystemDataManager NODES ===

@onready var PORJECT_SETTINGS = ProjectSettingsManager

# === VARIABLES === 

var console_log:Array      = []
var command_history:Array  = []

# === PRELOAD ===
var rich_text = preload("res://singletone/command_system_dependecy/RichTextLabel.tscn")

# === FUNCTIONS ===

func echo(value, record:bool = true)->void:
	if get_parent().command_line_state:
		var result:String = str(value)
		Logger.info("command executed - echo({value})".format({"value":result}))
		var output = rich_text.instantiate()
		if record:
			console_log.append(result)
			
		output.text = result
		Console.add_child(output)
	else:
		pass

func clear()->void:
	Logger.info("command executed - clear")
	for x in Console.get_children():
		Console.remove_child(x)
		x.queue_free()

func ls_commands(node = self)->void:
	Logger.info("command executed - ls_commands({node})".format({"node":node}))
	echo("[center]=== LIST OF COMMAND ===[/center]", false)
	for x in node.get_method_list():
		echo(x["name"])
	echo("[center]=== END ===[/center]", false)

func ls_console_log()->void:
	Logger.info("command executed - ls_console_log")
	echo("[center]=== LIST OF COMMAND ===[/center]", false)
	for x in console_log.size():
		echo(console_log[x])
	echo("[center]=== END ===[/center]", false)

func ls_command_history()->void:
	Logger.info("command executed - ls_command_history")
	echo("[center]=== LIST OF COMMAND ===[/center]", false)
	for x in command_history.size():
		echo(command_history[x])
	echo("[center]=== END ===[/center]", false)

func remove_save_files()->void:
	Logger.info("command executed - remove_save_files")
	ResourceManager.remove_all_files(ResourceManager.PIN)
	ResourceManager.remove_all_files(ResourceManager.MAP)
	ResourceManager.remove_all_files(ResourceManager.ARTICLE)
	ResourceManager.remove_all_files(ResourceManager.SYMBOL_TEMP)

	echo("all file removed")

func run_script(path:String)->void:
	Logger.info("command executed - run_script({path})".format({"path":path}))
	echo("=== RUNING EXTERNAL SCRIPT ({script_name}) ===".format({"script_name" : path}))
	var script:Script = load(path)
	var new_node = Node.new()
	new_node.set_script(script)
	new_node.queue_free()
	echo("=== RUNING EXTERNAL SCRIPT ({script_name}) ===".format({"script_name" : path}))
	Logger.info("script was successfully executed")
