<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# GutScene.gd

**Extends:** [Panel](../Panel)

## Description

## Constants Descriptions

### DEFAULT\_TITLE

```gdscript
const DEFAULT_TITLE: String = "Gut: The Godot Unit Testing tool."
```

## Method Descriptions

### elapsed\_time\_as\_str

```gdscript
func elapsed_time_as_str()
```

### run\_mode

```gdscript
func run_mode(is_running = true)
```

####################
Public
####################

### set\_scripts

```gdscript
func set_scripts(scripts)
```

### select\_script

```gdscript
func select_script(index)
```

### get\_selected\_index

```gdscript
func get_selected_index()
```

### get\_log\_level

```gdscript
func get_log_level()
```

### set\_log\_level

```gdscript
func set_log_level(value)
```

### set\_ignore\_pause

```gdscript
func set_ignore_pause(should)
```

### get\_ignore\_pause

```gdscript
func get_ignore_pause()
```

### get\_text\_box

```gdscript
func get_text_box()
```

### end\_run

```gdscript
func end_run()
```

### set\_progress\_script\_max

```gdscript
func set_progress_script_max(value)
```

### set\_progress\_script\_value

```gdscript
func set_progress_script_value(value)
```

### set\_progress\_test\_max

```gdscript
func set_progress_test_max(value)
```

### set\_progress\_test\_value

```gdscript
func set_progress_test_value(value)
```

### clear\_progress

```gdscript
func clear_progress()
```

### pause

```gdscript
func pause()
```

### set\_title

```gdscript
func set_title(title = null)
```

### add\_passing

```gdscript
func add_passing(amount = 1)
```

### add\_failing

```gdscript
func add_failing(amount = 1)
```

### clear\_summary

```gdscript
func clear_summary()
```

### maximize

```gdscript
func maximize()
```

### clear\_text

```gdscript
func clear_text()
```

### scroll\_to\_bottom

```gdscript
func scroll_to_bottom()
```

### set\_font\_size

```gdscript
func set_font_size(new_size)
```

### set\_font

```gdscript
func set_font(base_name)
```

### set\_default\_font\_color

```gdscript
func set_default_font_color(color)
```

### set\_background\_color

```gdscript
func set_background_color(color)
```

### get\_waiting\_label

```gdscript
func get_waiting_label()
```

## Signals

- signal end_pause(): 
- signal ignore_pause(): 
- signal log_level_changed(): 
- signal run_script(): 
- signal run_single_script(): 
