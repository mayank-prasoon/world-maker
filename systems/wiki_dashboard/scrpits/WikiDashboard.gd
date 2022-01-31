extends Control

var wiki_editor:PackedScene    = load("res://systems/wiki_dashboard/ui_elements/wiki_editor/WikiEditor.tscn")

func _on_AddNewCardButton_pressed():
	get_parent().add_child(wiki_editor.instance())
	self.queue_free()
