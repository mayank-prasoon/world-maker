<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# MapLayer

**Extends:** [Resource](../Resource)

## Description

## Enumerations

### blending\_mode

```gdscript
const blending_mode: Dictionary = {"add":4,"burn":6,"custom_shader":13,"darken":5,"difference":3,"divide":2,"dodge":7,"hard_light":12,"lighten":8,"multiply":1,"normal":0,"overlay":9,"screen":10,"soft_light":11}
```

## Constants Descriptions

### add

```gdscript
const add: int = 4
```

### burn

```gdscript
const burn: int = 6
```

darker

### custom\_shader

```gdscript
const custom_shader: int = 13
```

custom_shader

### darken

```gdscript
const darken: int = 5
```

darker

### difference

```gdscript
const difference: int = 3
```

### divide

```gdscript
const divide: int = 2
```

### dodge

```gdscript
const dodge: int = 7
```

lighter

### hard\_light

```gdscript
const hard_light: int = 12
```

lighting

### lighten

```gdscript
const lighten: int = 8
```

lighter

### multiply

```gdscript
const multiply: int = 1
```

basic maths

### normal

```gdscript
const normal: int = 0
```

basic maths

### overlay

```gdscript
const overlay: int = 9
```

### screen

```gdscript
const screen: int = 10
```

### soft\_light

```gdscript
const soft_light: int = 11
```

lighting

## Property Descriptions

### layer\_name

```gdscript
export var layer_name: String = ""
```

### layer\_path

```gdscript
export var layer_path: String = ""
```

### layer\_description

```gdscript
export var layer_description: String = ""
```

### layer\_visibility

```gdscript
export var layer_visibility = false
```

- **Setter**: `set_layer_visibility`

### layer\_shader

```gdscript
export var layer_shader: int = 0
```

### layer\_custom\_shader

```gdscript
export var layer_custom_shader: VisualShader = "[Object:null]"
```

### layer\_opacity

```gdscript
export var layer_opacity: float = 100
```

## Method Descriptions

### set\_layer\_visibility

```gdscript
func set_layer_visibility(value: int) -> void
```

### fetch\_shader\_material <small>(static)</small>

```gdscript
func fetch_shader_material(blend_mode: int, custom_shader_resource: VisualShader) -> ShaderMaterial
```

