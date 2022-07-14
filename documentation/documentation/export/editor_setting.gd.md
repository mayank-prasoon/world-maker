<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# editor\_setting.gd

**Extends:** [Node](../Node)

## Description

## Property Descriptions

### editor\_settings\_save\_location

```gdscript
var editor_settings_save_location: String = "user://settings.tres"
```

=== VARIABLES ===

### settings

```gdscript
var settings: EditorSettingsTemplate
```

### current\_path

```gdscript
var current_path: String = "res://"
```

## Method Descriptions

### editor\_settings\_file\_handler

```gdscript
func editor_settings_file_handler() -> void
```

=== project ===
handles the settings file for the editor

### check\_if\_editor\_settings\_file\_exists

```gdscript
func check_if_editor_settings_file_exists() -> bool
```

check if editor settings file - user://settings.tres exists

### get\_projects

```gdscript
func get_projects() -> Array
```

get project list from settings.tres

### add\_new\_project

```gdscript
func add_new_project(project_name: String, project_path: String)
```

add a new project to list projects in settings.tres

### remove\_project

```gdscript
func remove_project(project_name: String, project_path: String)
```

remove project from project list from settings.tres

### last\_project

```gdscript
func last_project() -> Dictionary
```

=== last project ===
fetch the last project

### add\_last\_project

```gdscript
func add_last_project(project_index: int)
```

### add\_last\_project\_by\_name

```gdscript
func add_last_project_by_name(project_name: String, project_location: String) -> void
```

### get\_pinned\_project

```gdscript
func get_pinned_project() -> Array
```

=== pinned project ===

### pin\_project

```gdscript
func pin_project(project_index: int) -> void
```

### upin\_project

```gdscript
func upin_project(project_index) -> void
```

### open\_project

```gdscript
func open_project(index: int)
```

=== SIGNALS ===