<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# MapPinStateMachine.gd

**Extends:** [StateMachine](../StateMachine) < [Node](../Node)

## Description

## Enumerations

### STATE

```gdscript
const STATE: Dictionary = {"CLICK":2,"DRAG":3,"HOVER":1,"NULL":0}
```

## Property Descriptions

### mouse\_inside

```gdscript
var mouse_inside: bool = false
```

### clicked

```gdscript
var clicked: bool = false
```

### dragged

```gdscript
var dragged
```

### hover\_animation

```gdscript
var hover_animation: AnimationPlayer
```

=== NODES ===
animation

### progress\_bar\_animation

```gdscript
var progress_bar_animation: AnimationPlayer
```

=== NODES ===
animation

### drag\_animation

```gdscript
var drag_animation: AnimationPlayer
```

### timer

```gdscript
var timer: Timer
```

## Method Descriptions

### mouse\_interaction

```gdscript
func mouse_interaction() -> void
```

### reset\_drag

```gdscript
func reset_drag()
```

