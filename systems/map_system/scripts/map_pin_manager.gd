extends Node

signal open_menu

# === enums ===

enum MENU {
	ADD,
	DELETE,
	COPY,
	CUT,
	PASTE
}

enum ADD {
	PIN,
	TEXT,
	NOTES
}

# === nodes ===

onready var pop_up_menu:PopupMenu = $"../PopupMenu"

func _ready()->void:
	var _x = connect("open_menu", self, "_open_menu")
	
	# add menus
	pop_up_menu.add_submenu_item("add", "AddMenu")
	pop_up_menu.add_item("delete")
	pop_up_menu.add_separator()
	pop_up_menu.add_item("copy")
	pop_up_menu.add_item("cut")
	pop_up_menu.add_item("paste")

# opens the menu
func _open_menu()->void:
	pop_up_menu.popup()
	pop_up_menu.rect_global_position = get_viewport().get_mouse_position()

# event loop
func _on_Menu_gui_input(event):
	# run when right mouse button is clicked
	if event is InputEventMouseButton:
		if event.is_pressed() && event.button_index == BUTTON_MASK_RIGHT:
			emit_signal("open_menu")

# right click pop up menu logic
# NOTE : work in progress...
func _on_PopupMenu_id_pressed(id):
	match id:
		MENU.DELETE:
			print("delete pin")
		MENU.COPY:
			pass

# right click pop up sub menu logic
# NOTE : work in progress...
func _on_AddMenu_id_pressed(id):
	match id:
		ADD.PIN:
			print("pin")
		ADD.TEXT:
			print("text")
		ADD.NOTES:
			print("notes")
