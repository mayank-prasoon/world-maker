extends Control

signal image_loaded

onready var videoPlayer: = $"VideoPlayer"

export(int, "low", "medium", 'high') var resolution:int = 2

var thread = Thread.new()

func _ready() -> void:
	var _t = thread.start(self, '_load_background', resolution)
	
func _load_background(quality:int):
	match quality:
		0:
			var video:Resource = load("res://assests/MainMenu/Rocks_low.webm")
			videoPlayer.stream = video
			videoPlayer.play()
		1:
			var video:Resource = load("res://assests/MainMenu/Rocks_medium.webm")
			videoPlayer.stream = video
			videoPlayer.play()
		2:
			var video:Resource = load("res://assests/MainMenu/Rocks_high.webm")
			videoPlayer.stream = video
			videoPlayer.play()
	
	call_deferred('emit_signal', "image_loaded")


func _on_VideoPlayer_finished() -> void:
	videoPlayer.play()

func _exit_tree() -> void:
	thread.wait_to_finish()
