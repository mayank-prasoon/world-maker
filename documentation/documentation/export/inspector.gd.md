<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# inspector.gd

**Extends:** [Control](../Control)

## Description

## Property Descriptions

### state

```gdscript
export var state = false
```

show the inspector

### switch

```gdscript
var switch: Object
```

### container\_node

```gdscript
var container_node
```

node

## Method Descriptions

### display\_toggle

```gdscript
func display_toggle() -> void
```

------------------------------------------------------------------------------
toggle the display

### open\_inspector

```gdscript
func open_inspector() -> void
```

------------------------------------------------------------------------------
play open animation

### close\_inspector

```gdscript
func close_inspector() -> void
```

play close animation

### change\_inspector\_state

```gdscript
func change_inspector_state(new_state) -> void
```

change inspector

### inspector\_slide\_animation

```gdscript
func inspector_slide_animation(init_pos, final_pos) -> void
```

------------------------------------------------------------------------------
play the open/close animation of the inspector

### add\_map\_pin\_inspector

```gdscript
func add_map_pin_inspector(map_pin_resource: MapPin, map_pin_node: Node2D) -> void
```

------------------------------------------------------------------------------
add map pin inspector

### add\_map\_comment\_inspector

```gdscript
func add_map_comment_inspector(map_comment_resource: MapComment, map_comment_node: Node2D) -> void
```

------------------------------------------------------------------------------
add map comment inspector

### clear\_inspector

```gdscript
func clear_inspector() -> void
```

------------------------------------------------------------------------------

## Sub\-classes

### Switch

#### Property Descriptions

### state

```gdscript
var state
```

### object

```gdscript
var object
```

### method\_1

```gdscript
var method_1: String = ""
```

method called when the state is true

### method\_2

```gdscript
var method_2: String = ""
```

method called when the state is false

#### Method Descriptions

### \_init

```gdscript
func _init(node, true_state_method: String, false_state_method: String) -> void
```

### switch

```gdscript
func switch() -> void
```

