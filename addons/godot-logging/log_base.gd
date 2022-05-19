tool
extends Node

var log_file = null
export var persist_debug = true
var logy = null

export var file_dir = "user://"
export var file_name = "{dt}.log"
export var file_name_time_format = "{month}-{year}"
export var formatting = "{dt} {level} {msg}"
export var time_format = "{month}/{day}/{year} {24hour}:{min}:{sec}"

# Allow toggling what you want
export var DEBUG = true
export var INFO = true
export var WARN = true
export var ERROR = true
export var CRIT = true

func _enter_tree():
	logy = self
	editor_description = "Logger V1.2 ApolloX"
	logy.editor_description = "Logger V1.2 ApolloX"
	logy.setup()
	return logy

func setup():
	log_file = File.new()
	var dtnow = timestamp(file_name_time_format)
	if !log_file.file_exists(file_dir + file_name.format({"dt": dtnow})) or !persist_debug:
		log_file.open(file_dir + file_name.format({"dt": dtnow}), File.WRITE)
		log_file.close()
		log_file.open(file_dir + file_name.format({"dt": dtnow}), File.READ_WRITE)
		log_file.seek_end()
	else:
		log_file.open(file_dir + file_name.format({"dt": dtnow}), File.READ_WRITE)
		log_file.seek_end()

# Assistant Functions
func pos2str(pos: Vector2 = Vector2(0, 0)) -> String:
	return "(" + str(pos.x) + ", " + str(pos.y) + ")"

func timestamp(fmat : String ="{month}/{day}/{year} {24hour}:{min}:{sec}", in_utc: bool = false):
	var t = OS.get_datetime(in_utc)
	var hour12 = t.hour
	var ampm = "" # Fill it in only if 12hour is requested
	if "12hour" in fmat: # Only use if 12hour is visible in formating
		ampm = "AM"
		if hour12 > 12:
			hour12 -= 12
			ampm = "PM"
	var result = fmat.format({"month": str(t.month).pad_zeros(2), "day": str(t.day).pad_zeros(2), "year": str(t.year).pad_zeros(4), "24hour": str(t.hour).pad_zeros(2), "12hour": str(hour12).pad_zeros(2), "min": str(t.minute).pad_zeros(2), "sec": str(t.second).pad_zeros(2), "ampm": str(ampm)})
	return result

func debug(msg : String):
	if DEBUG:
		var dt = timestamp(time_format)
		var line = formatting.format({"dt": dt, "level": "DEBUG   ", "msg": msg})
		if log_file != null:
			log_file.seek_end()
			log_file.store_string(line + "\n")
			log_file.flush()

func info(msg : String):
	if INFO:
		var dt = timestamp(time_format)
		var line = formatting.format({"dt": dt, "level": "INFO    ", "msg": msg})
		if log_file != null:
			log_file.seek_end()
			log_file.store_string(line + "\n")
			log_file.flush()

func warn(msg : String):
	if WARN:
		var dt = timestamp(time_format)
		var line = formatting.format({"dt": dt, "level": "WARN    ", "msg": msg})
		if log_file != null:
			log_file.seek_end()
			log_file.store_string(line + "\n")
			log_file.flush()

func warning(msg : String):
	if WARN:
		warn(msg)

func error(msg : String, and_exit: bool = false):
	if ERROR:
		var dt = timestamp(time_format)
		var line = formatting.format({"dt": dt, "level": "ERROR   ", "msg": msg})
		if log_file != null:
			log_file.seek_end()
			log_file.store_string(line + "\n")
			log_file.flush()
		if and_exit:
			var my_pid = OS.get_process_id()
			var _ec = OS.kill(my_pid)

func crit(msg : String, and_exit: bool = true):
	if CRIT:
		var dt = timestamp(time_format)
		var line = formatting.format({"dt": dt, "level": "CRITICAL", "msg": msg})
		if log_file != null:
			log_file.seek_end()
			log_file.store_string(line + "\n")
			log_file.flush()
		if and_exit:
			var my_pid = OS.get_process_id()
			var _ec = OS.kill(my_pid)

func critical(msg : String, and_exit: bool = true):
	if CRIT:
		crit(msg, and_exit)
