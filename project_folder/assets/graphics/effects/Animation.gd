class_name Animaion
extends Tween

# === EXPORT ===
export(String, 'zoom', 'pop_bounce') var animation = 'pop_bounce'

# === FUNCTIONS ===

# === POP ANIMATION ===
# This uses the tween animation class

func popBounce()->void:
# this is pops in the parent node from the center of the pivot offset 
	var parent: = get_parent()
	var _i = self.interpolate_property(
		parent, 'rect_scale', Vector2(0,0), Vector2(1, 1), 0.5, Tween.TRANS_QUINT, Tween.EASE_IN_OUT
	)
	var _s = self.start()


func popBounceBack()->void:
# this is pops out the parent node from the center of the pivot offset 
	var parent: = get_parent()
	var _i = self.interpolate_property(
		parent, 'rect_scale', Vector2(1, 1), Vector2(0,0), 0.5, Tween.TRANS_QUINT, Tween.EASE_IN_OUT
	)
	var _s = self.start()


func pop(state:bool)->void:
# this is a switch for pop animation
	if state:
		popBounce()
	else:
		popBounceBack()

# === SHIRNK ANIMATION ===
# This uses the tween animation class

func shrinkEnter()->void:
# this shrinks in the parent node from the side of the pivot offset
	var parent: = get_parent()
	var _i: = self.interpolate_property(
		parent, 'rect_scale', Vector2(0,1), Vector2(1,1), 0.25, Tween.TRANS_QUAD, Tween.EASE_IN_OUT
	)
	var _s: = self.start()


func shrinkExit()->void:
# this shrinks out the parent node from the side of the pivot offset
	var parent: = get_parent()
	var _i: = self.interpolate_property(
		parent, 'rect_scale', Vector2(1,1), Vector2(0,1), 0.25, Tween.TRANS_QUAD, Tween.EASE_IN_OUT
	)
	var _s: = self.start()


func shrink(state:bool)->void:
# this is a switch for shrink animation
	if state:
		shrinkEnter()
	else:
		shrinkExit()


# === ROTATE ANIMATION ===
# This uses the tween animation class

func rotateLeft()->void:
# this rotate the parent node to the left (initial position) from the pivot offset
	var parent: = get_parent()
	var _i: = self.interpolate_property(
		parent, "rect_rotation", 0, -180, 0.25, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	var _s: = self.start()


func rotateRight()->void:
# this rotate the parent node to the right from the pivot offset
	var parent: = get_parent()
	var _i: = self.interpolate_property(
		parent, "rect_rotation", -180, 0, 0.25, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	var _s: = self.start()


func rotate(state:bool)->void:
# this is a switch for rotate animation
	if state:
		rotateLeft()
	else:
		rotateRight()


# === VISIBLITY ANIMATION ===
# This uses the tween animation class

func visibleMax():
# this maximize the alpha of the parent node
	var parent: = get_parent()
	var _i: = self.interpolate_property(
		parent, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.25, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	var _s: = self.start()


func visibleMin()->void:
# this minimize the alpha of the parent node [making it invisible]
	var parent: = get_parent()
	var _i: = self.interpolate_property(
		parent, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.25, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	var _s: = self.start()

func visiblity(state:bool)->void:
# this is a switch for visible animation
	if state:
		visibleMin()
	else:
		visibleMax()

# === SLIDE ANIMATION ===
# This uses the tween animation class

func slideEnter(new_postion:Vector2)->void:
# this slides in the parent node from the side of the pivot offset
	var parent: = get_parent()
	var _i: = self.interpolate_property(
		parent, "rect_position", parent.get_position() , new_postion, 0.25, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	var _s: = self.start()

func slideExit(new_postion:Vector2)->void:
# this slides out the parent node from the side of the pivot offset
	var parent: = get_parent()
	var _i: = self.interpolate_property(
		parent, "rect_position", parent.get_position() , new_postion, 0.25, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	var _s: = self.start()

func slide(state:bool, true_state_position:Vector2, false_state_postion:Vector2)->void:
	if state:
		slideEnter(true_state_position)
	else:
		slideExit(false_state_postion)



# === COMMENTED FUNCTIONS ===

#onready var parent_scale:Vector2 = parent.rect_scale
#onready var desired_scale:Vector2 = parent_scale

#func _physics(_delta: float) -> void:
#	parent_scale = lerp(parent_scale, desired_scale, 0.2)

#func _ready() -> void:
#	parent_scale = Vector2(0.0, 0.0)

#	desired_scale = Vector2(1.0, 1.0)
#	desired_scale = Vector2(0.0, 0.0)
