<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# layers.gd

**Extends:** [Control](../Control)

## Description

## Property Descriptions

### texture\_node

```gdscript
var texture_node: TextureRect
```

=== VARIABLE ===

### map\_layer\_resources

```gdscript
var map_layer_resources: MapLayer
```

### move

```gdscript
var move: bool = false
```

### mouse\_enter

```gdscript
var mouse_enter: bool = false
```

### hover

```gdscript
var hover: bool = false
```

### default\_style\_box

```gdscript
var default_style_box
```

### selected\_style\_box

```gdscript
var selected_style_box
```

### selected

```gdscript
var selected: bool = false
```

true when the node is selected

### default\_rect\_size

```gdscript
var default_rect_size
```

variable realated to animation

### default\_rect\_pos

```gdscript
var default_rect_pos
```

### rect\_size\_value

```gdscript
var rect_size_value: Vector2 = "(272, 30)"
```

### rect\_pos\_value

```gdscript
var rect_pos_value: Vector2 = "(0, 0)"
```

## Method Descriptions

### setup\_layer

```gdscript
func setup_layer() -> void
```

### layer\_selected

```gdscript
func layer_selected() -> void
```

------------------------------------------------------------------------------

### lerp\_animation

```gdscript
func lerp_animation() -> void
```

------------------------------------------------------------------------------
=== UI ANIMATIONS ===

### set\_position\_size\_value

```gdscript
func set_position_size_value(pos: Vector2, size: Vector2)
```

### reset\_to\_default

```gdscript
func reset_to_default() -> void
```

### get\_drag\_data

```gdscript
func get_drag_data(_position) -> Dictionary
```

=== DARG AND DROP SYSTEM ===
exicutes when the control node is being dragged

### can\_drop\_data

```gdscript
func can_drop_data(_position, _data) -> bool
```

check if it can drop

### drop\_data

```gdscript
func drop_data(_position, data) -> void
```

exicute when a dragged control node is dropped

### move\_layer

```gdscript
func move_layer(data)
```

moves layer

### set\_layer\_blend\_mode

```gdscript
func set_layer_blend_mode(blend_mode: int) -> void
```

------------------------------------------------------------------------------
=== LAYER SETTING(s) ===

### set\_layer\_opacity

```gdscript
func set_layer_opacity(opacity: float) -> void
```

### set\_layer\_visibility

```gdscript
func set_layer_visibility(visiblity: bool) -> void
```

### if\_inside\_rect

```gdscript
func if_inside_rect() -> bool
```

=== INPUT SYSTEM ===
## IMPORTANT NOTE ###
due to the broken nature of built-in mouse
enter and exit signal it has been re-written
the built in is still there but it is
recommended to not use ti
check is mouse is inside the node

### check\_mouse\_enter

```gdscript
func check_mouse_enter() -> void
```

mouse enter and exit system

## Signals

- signal mouse_pointer_entered(): 
- signal mouse_pointer_exited(): 
