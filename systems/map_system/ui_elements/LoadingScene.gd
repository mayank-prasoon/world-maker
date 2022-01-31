
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

onready var progress_bar:ProgressBar = $ProgressBar

# === variables === 

export(float) var new_value:float = 0
export(float) var min_value:float = 0
export(float) var max_value:float = 100

func _ready():
	progress_bar.min_value = min_value
	progress_bar.max_value = max_value

# system loop
func _process(_delta)->void:
	# lerps form the value to new value
	progress_bar.value = lerp(progress_bar.value, new_value, 0.2)

# set new value
func set_new_value(new_value:float):
	self.new_value = new_value

func _on_ProgressBar_value_changed(value):
	# free the node when progress is completed
	if (value == progress_bar.max_value):
		self.queue_free()
