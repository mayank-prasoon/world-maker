<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Collector.gd

**Extends:** [SceneTree](../SceneTree)

## Description

## Method Descriptions

### find\_files

```gdscript
func find_files(dirpath: String = "", patterns: PoolStringArray = [], is_recursive: bool = false, do_skip_hidden: bool = true) -> PoolStringArray
```

Returns a list of file paths found in the directory.

**Arguments**

- dirpath: path to the directory from which to search files.
- patterns: an array of string match patterns, where "*" matches zero or more
  arbitrary characters and "?" matches any single character except a period
  ("."). You can use it to find files by extensions. To find only GDScript
  files, ["*.gd"]
- is_recursive: if `true`, walks over subdirectories recursively, returning all
  files in the tree.

### save\_text

```gdscript
func save_text(path: String = "", content: String = "") -> void
```

Saves text to a file.

### get\_reference

```gdscript
func get_reference(files: PoolStringArray = [], refresh_cache: bool = false) -> Dictionary
```

Parses a list of GDScript files and returns a list of dictionaries with the
code reference data.

If `refresh_cache` is true, will refresh Godot's cache and get fresh symbols.

### print\_pretty\_json

```gdscript
func print_pretty_json(reference: Dictionary) -> String
```

