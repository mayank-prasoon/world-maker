extends Node

var log_file_template = preload("res://assets/file templates/log_file_template/log_file_template.gd")
var log_file_location = SystemDataManager.root_save_file_path + "/.system_logs.tres"

func _init():
	var file      = File.new()
	if !file.file_exists(log_file_location):
		var y = log_file_template.new()
		var _x = ResourceSaver.save(log_file_location, y)
		print(log_file_location)

func log_new_event(event:String):
	var date_time = OS.get_datetime()
	var x = ResourceLoader.load(log_file_location)
	x.events.append("[{3}:{4}:{5} - {0}/{1}/{2}] : {event}".format(
		{
			"3":date_time['hour'],
			"4":date_time['minute'],
			"5":date_time['second'],

			"0":date_time['day'],
			"1":date_time['month'],
			"2":date_time['year'],

			"event":event
		}
	))

	var _y = ResourceSaver.save(log_file_location, x)
