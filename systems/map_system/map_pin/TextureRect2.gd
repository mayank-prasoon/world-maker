extends NinePatchRect

var desired_scale:Vector2 = self.rect_scale

func _physics_process(_delta: float) -> void:
	self.rect_scale = lerp(self.rect_scale, desired_scale, 0.2)

func _ready() -> void:
	self.rect_scale = Vector2(0.0, 0.0)

func popBounce()->void:
	desired_scale = Vector2(1.0, 1.0)


func popBounceBack()->void:
	desired_scale = Vector2(0.0, 0.0)


func _on_Area2D_hover_out() -> void:
	popBounceBack()

func _on_Area2D_hover_over() -> void:
	popBounce()
