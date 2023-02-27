<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# CameraMovement

**Extends:** [Camera2D](../Camera2D)

## Description

## Property Descriptions

### zoomSpeed

```gdscript
export var zoomSpeed: Vector2 = "(0.100001, 0.100001)"
```

### minZoom

```gdscript
export var minZoom: Vector2 = "(0.500001, 0.500001)"
```

### maxZoom

```gdscript
export var maxZoom: Vector2 = "(2.600001, 2.600001)"
```

### defaultPosition

```gdscript
export var defaultPosition: Vector2 = "(0, 0)"
```

### panSpeed

```gdscript
export var panSpeed: float = 0.2
```

### desiredZooom

```gdscript
var desiredZooom: Vector2
```

### defaultZoom

```gdscript
export var defaultZoom: Vector2 = "(2, 2)"
```

### panning

```gdscript
var panning: bool = false
```

### disableMouse

```gdscript
var disableMouse: bool = false
```

- **Setter**: `set_disable_camera`

### desiredOffset

```gdscript
var desiredOffset: Vector2
```

## Method Descriptions

### set\_disable\_camera

```gdscript
func set_disable_camera(value) -> void
```

### zoomControl

```gdscript
func zoomControl(event: InputEvent) -> void
```

zoom control

### cameraMovement

```gdscript
func cameraMovement(event: InputEvent) -> void
```

camera control

### checkCameraReset

```gdscript
func checkCameraReset(event: InputEvent) -> void
```

### cameraReset

```gdscript
func cameraReset() -> void
```

### cameraZoomIn

```gdscript
func cameraZoomIn() -> void
```

### cameraZoomOut

```gdscript
func cameraZoomOut() -> void
```

