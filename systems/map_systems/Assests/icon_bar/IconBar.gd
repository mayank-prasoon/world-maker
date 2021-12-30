extends Control

onready var iconContainer: = $Bar/ScrollContainer/IconContainer
onready var button:        = $Bar/TextureButton

# icon template
export(PackedScene) var iconTemplate:PackedScene = preload("res://Scene/map/Assests/icon/Icon.tscn")


#add new Icon types (baracks, library etc)
export(Array, String) var newIconTypes:Array

var threads:Array = []
var mutex:Mutex

var iconTypeList: = [
	'IMPORTANT',
	
	# war
	'BATTLE',
	'WAR', 
	
	#recidence
	'HOUSE',
	'CASTLE',
	
	#shop
	'SHOP',
	'ARMORY',
	'WEAPONSMITH',
]

func _ready() -> void:
	add_to_group('icon_bar')
	addType()
	_add_icons()


func addType()->void:
	iconTypeList.append_array(newIconTypes)


func _on_TextureButton_pressed() -> void:
	var createIcon = get_tree().get_root().get_node('/root/Map/Camera2D/CanvasLayer/CreateIcon')
	createIcon.show()
	createIcon.playAnimation()
	button.focus_mode = Control.FOCUS_NONE


# creates a new button to add a new map/location icon
func addNewIcon(data)->void:
	mutex.lock()
	var icon = iconTemplate.instance()
	assignIconData(icon, data)

	iconContainer.call_deferred('add_child', icon)
	mutex.unlock()


func assignIconData(icon:Node, data:Array) -> void:
	icon.iconName      = data[0]
	icon.type          = data[1]
	icon.iconTexture   = data[2]
	icon.iconColorTag  = data[3]
	icon.textureOffset = data[4]


#add icon to the bottom icon bar
func _add_icons()->void:
	mutex = Mutex.new()
	for x in SystemIconData.iconName.size():
		var thread = Thread.new()
		thread.start(
			self,
			'addNewIcon',
			[
				SystemIconData.iconName[x],
				SystemIconData.iconType[x],
				SystemIconData.iconTexture[x],
				SystemIconData.iconColor[x],
				SystemIconData.iconOffset[x]
			]
		)
		threads.append(thread)


func _exit_tree() -> void:
	for x in threads:
		x.wait_to_finish()
