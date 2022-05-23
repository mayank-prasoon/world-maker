extends Control

func _on_HomeButton_pressed():
	EventBus.emit_signal("load_wiki_dashboard")

func _on_MapTabButton_pressed():
	EventBus.emit_signal("load_map_dashboard")

func _on_StatsTabButton_pressed():
	get_parent().get_child(1).queue_free()
