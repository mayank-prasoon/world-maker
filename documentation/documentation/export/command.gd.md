<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# command.gd

**Extends:** [Control](../Control)

## Description

## Property Descriptions

### animationPlayer

```gdscript
var animationPlayer: Node
```

## Method Descriptions

### blurBackground

```gdscript
func blurBackground() -> void
```

export (bool) var Animate:bool = true
func _ready()->void:
	if Animate == true:
		animationPlayer.play("blur_background")
	if Animate == false:
		animationPlayer.play_backwards("blur_background")

### unBlurBackground

```gdscript
func unBlurBackground() -> void
```

