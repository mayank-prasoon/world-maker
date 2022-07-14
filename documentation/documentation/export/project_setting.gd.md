<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# project\_setting.gd

**Extends:** [Node](../Node)

## Description

## Property Descriptions

### shortcut\_settings

```gdscript
var shortcut_settings
```

=== NODES ===

### save\_file\_location

```gdscript
var save_file_location: String = "/project_settings.tres"
```

=== VARIABLES ===

### project\_save\_template

```gdscript
var project_save_template
```

=== VARIABLES ===

### default\_keybinding

```gdscript
var default_keybinding: Dictionary
```

### project\_name

```gdscript
export var project_name = ""
```

=== SETTINGS ===
basic imformation

### project\_version

```gdscript
export var project_version = ""
```

=== SETTINGS ===
basic imformation

### date\_of\_creation

```gdscript
export var date_of_creation = ""
```

### project\_location

```gdscript
export var project_location = ""
```

### shortcuts

```gdscript
export var shortcuts: Dictionary = {}
```

shortcut

### visual\_settings

```gdscript
export var visual_settings: Dictionary = {}
```

shortcut

### addons

```gdscript
export var addons = []
```

mods and addons

## Method Descriptions

### open\_project

```gdscript
func open_project() -> void
```

### save\_file

```gdscript
func save_file() -> void
```

saves project settings file

### folder\_integrity

```gdscript
func folder_integrity() -> void
```

check for folder integrity

### open\_file

```gdscript
func open_file() -> void
```

### save\_project\_settings

```gdscript
func save_project_settings()
```

## Signals

- signal load_data(): === SIGNALS ===
