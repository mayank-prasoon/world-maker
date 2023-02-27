
# ====================================== #
#                  Note                  #
# ====================================== #
#                                        #
#  this scene is used as a cover while   #
#     loading data in the background     #
#                                        #
# ====================================== #

extends Control

signal set_new_value(new_value)

# === Nodes ===

@onready var progress_bar:ProgressBar = $ProgressBar

# === variables === 

@export var new_value: float:float = 0
@export var min_value: float:float = 0
@export var max_value: float:float = 100

func _ready()->void:
	# connect the signal
	var _x = self.connect("set_new_value",Callable(self,"set_new_value"))

	# assign value
	progress_bar.min_value = min_value
	progress_bar.max_value = max_value

# add new value
func add_new_value(value:float)->void:
	self.new_value += value
	
	$Tween.interpolate_property(
		progress_bar,
		'value',
		progress_bar.value,
		new_value, 0.5,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN_OUT
	)

	$Tween.start()
	
# self queue_free()
func _on_ProgressBar_value_changed(value)->void:
	# free the node when progress is completed
	if (value >= progress_bar.max_value):
		self.queue_free()
