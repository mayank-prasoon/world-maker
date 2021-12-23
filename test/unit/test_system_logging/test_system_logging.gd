extends "res://addons/gut/test.gd"


func test_logging():
	var p = Directory.new()
	p.remove("res://save_files/.system_logs.tres")

	var x = load("res://singletone/logging_system.gd")
	var y = x.new()
	y.log_new_event("pin name book added")

	assert_file_exists("res://save_files/.system_logs.tres")
	var q = ResourceLoader.load("res://save_files/.system_logs.tres")
	assert_eq(q.events[0].split(":")[-1], " pin name book added")

	y.free()
