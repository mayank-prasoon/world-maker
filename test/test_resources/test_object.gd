extends Reference

var resource = null setget set_resource

func _thread_reciver(new_resource)->void:
	set_resource(new_resource)

func set_resource(new_resource)->void:
	resource = new_resource
