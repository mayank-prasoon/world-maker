## This is just for test
class_name TestCharacter
extends CharacterBody2D

## constant speed
const SPEED = 100

var res:CharacterResourse = GlobalSetting.player_position_resourse

class CharacterMovementCommand extends Command:
	var command_name:String      = ''
	var object:CharacterResourse = null
	var property:String          = ''
	var old_position:Vector2     = Vector2()
	var new_position:Vector2     = Vector2()
	
	func _init():
		pass

# --------------------------------------------------------------------------------------------------

func _ready():
	GlobalEventBus.move_forward.connect(Callable(self, 'change_position'))

# --------------------------------------------------------------------------------------------------

func _physics_process(delta:float):
	_larp_to_position(res.character_position, delta)

# --------------------------------------------------------------------------------------------------

func _larp_to_position(value:Vector2, delta:float = 1.001)->void:
	self.position = lerp(self.position, value, 5*delta)

# --------------------------------------------------------------------------------------------------

func _input(event:InputEvent)->void:
	if event.is_pressed() and event is InputEventKey:
		if event.keycode == KEY_RIGHT:
			GlobalEventBus.move_forward.emit(Vector2(SPEED, 0))
		elif event.keycode == KEY_LEFT:
			GlobalEventBus.move_forward.emit(-1 * Vector2(SPEED, 0))
		elif event.keycode == KEY_UP:
			GlobalEventBus.move_forward.emit(-1 * Vector2(0, SPEED))
		elif event.keycode == KEY_DOWN:
			GlobalEventBus.move_forward.emit(Vector2(0, SPEED))
