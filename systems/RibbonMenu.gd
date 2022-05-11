extends Control

var wiki_dashboard:PackedScene = load("res://systems/wiki_dashboard/WikiDashboard.tscn")
var map_dashboard:PackedScene  = load("res://systems/map_system/MapDashboard.tscn")

onready var add_card_button:Button = get_parent().get_node("WikiDashboard/VBoxContainer/CardList/AddNewCardButton/Button")

func _on_HomeButton_pressed():
	get_parent().get_child(1).queue_free()
	get_parent().add_child(wiki_dashboard.instance())

func _on_MapTabButton_pressed():
	get_parent().get_child(1).queue_free()
	get_parent().add_child(map_dashboard.instance())

func _on_StatsTabButton_pressed():
	get_parent().get_child(1).queue_free()
