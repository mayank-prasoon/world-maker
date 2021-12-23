extends Node

onready var console:VBoxContainer = $CommandSystemInterface/Console/Log
onready var API:Node              = $CommandAPI
onready var command_line:LineEdit = $CommandSystemInterface/HBoxContainer/CommandInput


func _on_CommandInput_text_entered(command:String):
	execute_command(command)

func _on_CommandInput_text_changed(_command:String):
	pass # Replace with function body.


func _on_RunButton_pressed():
	execute_command(command_line.text)


func execute_command(command:String):
	var expression = Expression.new()
	var error

	if command in API:
		error = expression.parse(command, [])
	else:
		 error = expression.parse(command + "()", [])

	if error != OK:
		API.echo(expression.get_error_text())
		return
	var result = expression.execute([], API, true)
	if not expression.has_execute_failed():
		API.command_history.append(command)
		if result != null:
			API.echo(str(result))
	elif expression.has_execute_failed():
		API.echo('failed to exicute command `{c}`'.format({"c" : command}))
	
	command_line.text = ""
