extends Node

func _init():
	hello_world()

func hello_world():
	print("hello world")
	var _x = ResourceSaver.save("res://save_files/pins/hello_world.tres", MapPin.new())
