<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# ResourceManager

**Extends:** [Reference](../Reference)

## Description

## Constants Descriptions

### ARTICLE

```gdscript
const ARTICLE: int = 4
```

== article related ==

### COMMENT

```gdscript
const COMMENT: int = 2
```

### MAP

```gdscript
const MAP: int = 0
```

 == map related ==

### PIN

```gdscript
const PIN: int = 1
```

 == map related ==

### SYMBOL\_TEMP

```gdscript
const SYMBOL_TEMP: int = 3
```

## Method Descriptions

### resource\_path <small>(static)</small>

```gdscript
func resource_path(resource_type: int) -> String
```

return the path save location for the resource type

### save\_file <small>(static)</small>

```gdscript
func save_file(data: Dictionary, resource_type: int) -> void
```

save the resource

### open\_file <small>(static)</small>

```gdscript
func open_file(item_uid: String, resource_type: int) -> Resource
```

open the resource and return

### remove\_all\_files <small>(static)</small>

```gdscript
func remove_all_files(resource_type: int)
```

remove all the resource files from the folder

### remove\_file <small>(static)</small>

```gdscript
func remove_file(item_uid: String, resource_type: int) -> void
```

remove a specific resource files from the folder

## Sub\-classes

### SaveData

#### Property Descriptions

### thread

```gdscript
var thread
```

#### Method Descriptions

### \_init

```gdscript
func _init(path, resource)
```

initailization

### save

```gdscript
func save(args)
```

save the resources

### join\_thread

```gdscript
func join_thread()
```

join the thread the free it self