<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# event\_bus.gd

**Extends:** [Node](../Node)

## Description

=== NOTES ===
this is a global event signal manager

## Signals

- signal reload_system(): === MapSystem Resource ===
- signal save_map(map_resource): 
- signal create_new_map(map_name, map_texture, article): 
- signal change_map_to(new_map): 
- signal delete_current_map(): 
- signal create_new_layer(map_layer_resource): map layer
- signal change_layer_index(index): 
- signal assign_layer(map_resource): 
- signal save_map_layer(layer_resource, index): 
- signal mouse_inside_map_element(element): === map element ===
- signal mouse_outside_map_element(): 
- signal create_new_pin(position): map pin
- signal remove_map_pin(map_pin_resource): 
- signal save_map_pin(map_pin_resource): 
- signal add_pin_to_map(map_pin_resource): 
- signal move_pin_to_top(map_pin): 
- signal create_new_text(position): text
- signal remove_map_text(resource): 
- signal save_map_text(resource): 
- signal add_text_to_map(resource): 
- signal create_new_comment(position): comments
- signal remove_map_comment(resource): 
- signal save_map_comment(resource): 
- signal add_comment_to_map(resource): 
- signal create_new_annotation(): annotation
- signal remove_map_annotation(resource): 
- signal save_map_annotation(resource): 
- signal add_annotation_to_map(resource): 
- signal create_new_symbol_template(position): symbol template
- signal remove_map_symbol_template(resource): 
- signal save_map_symbol_template(resource): 
- signal toggle_inpector(): === Inspector System ===
if open close, if close open
- signal change_inspector_state(new_state): set the open close state of the inspector
- signal add_pin_inspector(map_pin_resource, node): add pin to the inspector
- signal add_text_inspector(map_text_resource, node): add text to the inspector
- signal add_comment_inspector(map_text_resource, node): add comment to the inspector
- signal clear_inspector(): clear the inspector
- signal open_article_panel(article_resources): === Article System ===
- signal close_article_panel(article_resources): 
- signal load_pin_template(): === Map Symbol template ===
- signal set_visiblity(visiblity): === Layer Option System ===
- signal set_layer_opacity(opacity): 
- signal set_layer_blend_mode(blend_mode): 
- signal set_map_layer(layer_node): 
- signal move_camera_to(positionq): ============================================================= #
                        CAMERA SYSTEM                         #
============================================================= #
these signals are realated to camera system inside other systems.
=== CameraSystem ===
- signal disable_camera(state): 
- signal zoom_in(): 
- signal zoom_out(): 
- signal reset_zoom(): 
- signal reset_position(): 
- signal complete_reset(): combination of both reset zoom and position
- signal edit_article(article): ============================================================= #
                        WIKI SYSTEM                           #
============================================================= #
these signals are realated to Wiki system inside other systems.
wiki editor
pop open Wiki Editor for editing article
- signal create_article(): pop open Wiki Editor for creating new article
- signal load_wiki_dashboard(): ============================================================= #
                      DASHBOARD MANAGER                       #
============================================================= #
- signal load_map_dashboard(): 
