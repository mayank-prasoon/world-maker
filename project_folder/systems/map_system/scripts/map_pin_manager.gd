extends Node

var mouse_inside_element:bool = false
var map_element               = null
# === enums ===

var menu = []


enum ADD {
	PIN,
	COMMENT
}

# === NODE(s) ===

onready var pop_up_menu:PopupMenu = $"../Camera2D/CanvasLayer/Menu/PopupMenu"

var mouse_position:Vector2 = Vector2(0,0)

# === METHODS === 

# ------------------------------------------------------------------------------


func _ready()->void:
	var _y = EventBus.connect("mouse_outside_map_element", self, '_on_mouse_outside_element')
	var _z = EventBus.connect("mouse_inside_map_element", self, '_on_mouse_inside_element')
	

# ------------------------------------------------------------------------------

func open_add_menu()->void:
	pop_up_menu.items = []
	pop_up_menu.rect_size.y = 0

	menu = []
	
	menu.append("add")
	pop_up_menu.add_submenu_item("add", "AddMenu")
	
	menu.append(0)
	pop_up_menu.add_separator()
	
	menu.append("delete map")
	pop_up_menu.add_item("delete map")
	
	
	if !check_if_map_exists(): # if map doesn't exists
		pop_up_menu.set_item_disabled(0, true)
		pop_up_menu.set_item_disabled(2, true)
	
	open_menu()

# ------------------------------------------------------------------------------

# opens the menu
func open_menu()->void:
	pop_up_menu.popup()
	pop_up_menu.rect_global_position = get_viewport().get_mouse_position()
	mouse_position                   = get_owner().get_global_mouse_position()

# ------------------------------------------------------------------------------

func open_pin_menu() ->void:
	pop_up_menu.items = []
	pop_up_menu.rect_size.y = 0
	
	menu = []
	
	menu.append("go to map")
	pop_up_menu.add_item("go to map")
	
	if map_element.pin_resource.linked_map == null:
		pop_up_menu.set_item_disabled(0, true)
	
	menu.append("edit pin")
	pop_up_menu.add_item("edit pin")
	
	menu.append(0)
	pop_up_menu.add_separator()
	
	menu.append("delete pin")
	pop_up_menu.add_item("delete")

	open_menu()
	

# ------------------------------------------------------------------------------

# event loop
func _unhandled_input(event):
	# run when right mouse button is clicked
	if event is InputEventMouseButton:
		if event.is_pressed() && event.button_index == BUTTON_MASK_RIGHT:
			if !mouse_inside_element:
				open_add_menu()
			if mouse_inside_element and map_element is MapPinNode:
				open_pin_menu()

# ------------------------------------------------------------------------------

	# run when left mouse button is clicked
		if event.is_doubleclick() && event.button_index == BUTTON_MASK_LEFT:
			if mouse_inside_element and map_element is MapPinNode:
				EventBus.emit_signal("add_pin_inspector", map_element.pin_resource, map_element)
				EventBus.emit_signal("open_article_panel", map_element.pin_resource.pin_article)

		elif event.is_pressed() && event.button_index == BUTTON_MASK_LEFT && !mouse_inside_element:
			EventBus.emit_signal('clear_inspector')
			EventBus.emit_signal("close_article_panel")

# ------------------------------------------------------------------------------

# right click pop up menu logic
# NOTE : work in progress...
func _on_PopupMenu_id_pressed(id):
	match menu[id]:
		"delete pin":
			EventBus.emit_signal("remove_map_pin", map_element.pin_resource)
			EventBus.emit_signal("clear_inspector")
			map_element.queue_free()

		"edit pin":
			EventBus.emit_signal("change_inspector_state", true)
			EventBus.emit_signal("add_pin_inspector", map_element.pin_resource, map_element)
			EventBus.emit_signal("move_camera_to", map_element.get_global_position())

		"go to map":
			EventBus.emit_signal("change_map_to", map_element.pin_resource.linked_map)

		"delete map":
			$"../Camera2D/CanvasLayer/CanvasLayer/ConfirmationDialog".popup_centered()

# ------------------------------------------------------------------------------

# right click pop up sub menu logic
# NOTE : work in progress...
func _on_AddMenu_id_pressed(id):
	match id:
		ADD.PIN:
			EventBus.emit_signal("create_new_pin", mouse_position)
		ADD.COMMENT:
			EventBus.emit_signal("create_new_comment", mouse_position)

# ------------------------------------------------------------------------------

func _on_mouse_inside_element(element)->void:
	map_element = element
	mouse_inside_element = true
	print_debug("mouse inside")

# ------------------------------------------------------------------------------

func _on_mouse_outside_element()->void:
	mouse_inside_element = false
	print_debug("mouse outside")

# ------------------------------------------------------------------------------

# check if any map exists
func check_if_map_exists()->bool:
	if get_owner().map_texture_collection_node.get_children().empty():
		print_debug("there are no maps")
		return false
	else:
		print_debug("there are maps")
		return true
