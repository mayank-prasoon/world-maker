extends Node

# === NODES ===

onready var console:VBoxContainer = $CanvasLayer/CommandSystemInterface/Console/Log
onready var API:Node              = $CommandAPI
onready var command_line:LineEdit = $CanvasLayer/CommandSystemInterface/HBoxContainer/CommandInput

# === VARIABLES ===

export(bool) var command_line_state = false

func _ready():
	$EffectLayer/Control.visible = false
	$CanvasLayer/CommandSystemInterface.visible = command_line_state

func _on_CommandInput_text_entered(command:String) -> void:
	execute_command(command)

func _on_CommandInput_text_changed(_command:String) -> void:
	pass

func _on_RunButton_pressed() -> void:
	execute_command(command_line.text)

func _input(event):
	if event.is_action_pressed("command line interface"):
		command_line_state = !command_line_state
		$CanvasLayer/CommandSystemInterface.visible = command_line_state
		
		if command_line_state:
			$EffectLayer/Control.visible = true
			$EffectLayer/Control/BackgroundBlur.blurBackground()
		elif !command_line_state:
			$AnimationPlayer.play("unblur")


func execute_command(command:String) -> void:
	var expression = Expression.new()
	var error

	if API.has_method(command):
		error = expression.parse(command + "()", [])
	else:
		error = expression.parse(command, [])

	if error != OK:
		API.echo(expression.get_error_text())
		Logger.info("command - {command} failed to exicute with parsing error {error}".format({"command":command, "error":error}))
		return

	var result = expression.execute([], API, true)
	if not expression.has_execute_failed():
		API.command_history.append(command)
		if result != null:
			API.echo(str(result))

	elif expression.has_execute_failed():
		API.echo('failed to exicute command `{c}`'.format({"c" : command}))
		Logger.info("command - {command} failed to exicute".format({"command":command}))
	
	command_line.text = ""
