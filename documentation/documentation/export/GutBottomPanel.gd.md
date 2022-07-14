<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# GutBottomPanel.gd

**Extends:** [Control](../Control)

## Description

## Constants Descriptions

### RESULT\_FILE

```gdscript
const RESULT_FILE: String = "user://.gut_editor.bbcode"
```

### RESULT\_JSON

```gdscript
const RESULT_JSON: String = "user://.gut_editor.json"
```

### RUNNER\_JSON\_PATH

```gdscript
const RUNNER_JSON_PATH: String = "res://.gut_editor_config.json"
```

### SHORTCUTS\_PATH

```gdscript
const SHORTCUTS_PATH: String = "res://.gut_editor_shortcuts.cfg"
```

## Property Descriptions

### TestScript

```gdscript
var TestScript
```

### GutConfigGui

```gdscript
var GutConfigGui
```

## Method Descriptions

### load\_shortcuts

```gdscript
func load_shortcuts()
```

---------------
Private
---------------

### load\_result\_output

```gdscript
func load_result_output()
```

---------------
Public
---------------

### set\_current\_script

```gdscript
func set_current_script(script)
```

### set\_interface

```gdscript
func set_interface(value)
```

### set\_plugin

```gdscript
func set_plugin(value)
```

### set\_panel\_button

```gdscript
func set_panel_button(value)
```

### write\_file

```gdscript
func write_file(path, content)
```

------------------------------------------------------------------------------
Write a file.
------------------------------------------------------------------------------

### get\_file\_as\_text

```gdscript
func get_file_as_text(path)
```

------------------------------------------------------------------------------
Returns the text of a file or an empty string if the file could not be opened.
------------------------------------------------------------------------------

### nvl

```gdscript
func nvl(value, if_null)
```

------------------------------------------------------------------------------
return if_null if value is null otherwise return value
------------------------------------------------------------------------------