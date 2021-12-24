extends Node

# === NODES ===

onready var console:VBoxContainer = $CommandSystemInterface/Console/Log
onready var API:Node              = $CommandAPI
onready var command_line:LineEdit = $CommandSystemInterface/HBoxContainer/CommandInput

# === VARIABLES ===

export(bool) var command_line_state = false

func _ready():
	$CommandSystemInterface.visible = command_line_state

func _on_CommandInput_text_entered(command:String) -> void:
	execute_command(command)

func _on_CommandInput_text_changed(_command:String) -> void:
	pass

func _on_RunButton_pressed() -> void:
	execute_command(command_line.text)

func execute_command(command:String) -> void:
	var expression = Expression.new()
	var error

	if API.has_method(command):
		error = expression.parse(command + "()", [])
	else:
		error = expression.parse(command, [])

	if error != OK:
		API.echo(expression.get_error_text())
		LoggingSystem.log_new_event("command - {command} failed to exicute with parsing error {error}".format({"command":command, "error":error}))
		return
	var result = expression.execute([], API, true)
	if not expression.has_execute_failed():
		API.command_history.append(command)
		if result != null:
			API.echo(str(result))
	elif expression.has_execute_failed():
		API.echo('failed to exicute command `{c}`'.format({"c" : command}))
		LoggingSystem.log_new_event("command - {command} failed to exicute".format({"command":command}))
	
	command_line.text = ""
