# === NOTES ===

# this is a global event signal manager 

extends Node

# ============================================================= #
#                          MAP SYSTEM                           #
# ============================================================= #

# these signal related to map system scene and it's UI elements.
# - map resource is MapData.
# - map layer resource is MapLayer.
# - map pin resources is MapPin.

# === MapSystem Resource ===

signal save_map(map_resource)

signal create_new_map(map_name, map_texture, article)

signal change_map_to(new_map)

signal delete_current_map()

# map layer

signal create_new_layer(map_layer_resource)

signal change_layer_index(index)

signal assign_layer(map_resource)

signal save_map_layer(layer_resource, index)


# === map element ===

signal mouse_inside_map_element(element)

signal mouse_outside_map_element()

# map pin

signal create_new_pin(position)

signal remove_map_pin(map_pin_resource)

signal save_map_pin(map_pin_resource)

signal add_pin_to_map(map_pin_resource)

signal move_pin_to_top(map_pin)

# text

signal create_new_text(position)

signal remove_map_text(resource)

signal save_map_text(resource)

signal add_text_to_map(resource)


# comments

signal create_new_comment(position)

signal remove_map_comment(resource)

signal save_map_comment(resource)

signal add_comment_to_map(resource)

# annotation

signal create_new_annotation()

signal remove_map_annotation(resource)

signal save_map_annotation(resource)

signal add_annotation_to_map(resource)

# symbol template

signal create_new_symbol_template(position)

signal remove_map_symbol_template(resource)

signal save_map_symbol_template(resource)

# === Inspector System ===

signal toggle_inpector()

signal change_inspector_state(new_state)

signal add_pin_inspector(map_pin_resource, node)

signal add_text_inspector(map_text_resource, node)

signal add_comment_inspector(map_text_resource, node)

signal clear_inspector()

# === Article System ===

signal open_article_panel(article_resources)

signal close_article_panel(article_resources)

# === Map Symbol template ===

signal load_pin_template()

# === Layer Option System ===

signal set_visiblity(visiblity)

signal set_layer_opacity(opacity)

signal set_layer_blend_mode(blend_mode)

signal set_map_layer(layer_node)


# ============================================================= #
#                         CAMERA SYSTEM                         #
# ============================================================= #

# these signals are realated to camera system inside other systems. 

# === CameraSystem ===

signal move_camera_to(positionq)

signal disable_camera(state)

signal zoom_in()

signal zoom_out()

signal reset_zoom()

signal reset_position()

signal complete_reset() # combination of both reset zoom and position


# ============================================================= #
#                         WIKI SYSTEM                           #
# ============================================================= #

# these signals are realated to Wiki system inside other systems. 

# wiki editor
signal edit_article(article) # pop open wiki Editor
