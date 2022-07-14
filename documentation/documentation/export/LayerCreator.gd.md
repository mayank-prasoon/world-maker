<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# LayerCreator.gd

**Extends:** [Panel](../Panel)

## Description

## Property Descriptions

### layer\_name

```gdscript
var layer_name: LineEdit
```

=== node ===

### layer\_texture

```gdscript
var layer_texture: LineEdit
```

=== node ===

### layer\_shader

```gdscript
var layer_shader: LineEdit
```

### create\_button

```gdscript
var create_button: Button
```

### layer\_node

```gdscript
var layer_node
```

### layer\_index

```gdscript
var layer_index
```

## Method Descriptions

### edit\_mode

```gdscript
func edit_mode(layer_resource: MapLayer, node: Control, index: int) -> void
```

### create\_confirmation\_dialog

```gdscript
func create_confirmation_dialog() -> void
```

generate confirmation dialog

### close\_the\_dialog

```gdscript
func close_the_dialog() -> void
```

close the dialog box~

### hide\_map\_creator

```gdscript
func hide_map_creator() -> void
```

hide dialog box

## Signals

- signal create_layer(layer_name, layer_texture, article): 
