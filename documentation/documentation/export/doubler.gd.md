<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# doubler.gd

## Method Descriptions

### \_init

```gdscript
func _init(strategy)
```

### get\_output\_dir

```gdscript
func get_output_dir()
```

###############
Public
###############

### set\_output\_dir

```gdscript
func set_output_dir(output_dir)
```

### get\_spy

```gdscript
func get_spy()
```

### set\_spy

```gdscript
func set_spy(spy)
```

### get\_stubber

```gdscript
func get_stubber()
```

### set\_stubber

```gdscript
func set_stubber(stubber)
```

### get\_logger

```gdscript
func get_logger()
```

### set\_logger

```gdscript
func set_logger(logger)
```

### get\_strategy

```gdscript
func get_strategy()
```

### set\_strategy

```gdscript
func set_strategy(strategy)
```

### get\_gut

```gdscript
func get_gut()
```

### set\_gut

```gdscript
func set_gut(gut)
```

### partial\_double\_scene

```gdscript
func partial_double_scene(path, strategy)
```

### double\_scene

```gdscript
func double_scene(path, strategy)
```

double a scene

### double

```gdscript
func double(path, strategy)
```

double a script/object

### partial\_double

```gdscript
func partial_double(path, strategy)
```

### partial\_double\_inner

```gdscript
func partial_double_inner(path, subpath, strategy)
```

### double\_inner

```gdscript
func double_inner(path, subpath, strategy)
```

double an inner class in a script

### double\_gdnative

```gdscript
func double_gdnative(native_class)
```

must always use FULL strategy since this is a native class and you won't get
any methods if you don't use FULL

### partial\_double\_gdnative

```gdscript
func partial_double_gdnative(native_class)
```

must always use FULL strategy since this is a native class and you won't get
any methods if you don't use FULL

### clear\_output\_directory

```gdscript
func clear_output_directory()
```

### delete\_output\_directory

```gdscript
func delete_output_directory()
```

### add\_ignored\_method

```gdscript
func add_ignored_method(path, method_name)
```

### get\_ignored\_methods

```gdscript
func get_ignored_methods()
```

### get\_make\_files

```gdscript
func get_make_files()
```

### set\_make\_files

```gdscript
func set_make_files(make_files)
```

### get\_method\_maker

```gdscript
func get_method_maker()
```

## Sub\-classes

### ScriptMethods

#### Property Descriptions

### built\_ins

```gdscript
var built_ins
```

### local\_methods

```gdscript
var local_methods
```

#### Method Descriptions

### is\_blacklisted

```gdscript
func is_blacklisted(method_meta)
```

### add\_built\_in\_method

```gdscript
func add_built_in_method(method_meta)
```

### add\_local\_method

```gdscript
func add_local_method(method_meta)
```

### to\_s

```gdscript
func to_s()
```

### ObjectInfo

#### Property Descriptions

### make\_partial\_double

```gdscript
var make_partial_double
```

### scene\_path

```gdscript
var scene_path
```

#### Method Descriptions

### \_init

```gdscript
func _init(path, subpath = null)
```

### instantiate

```gdscript
func instantiate()
```

Returns an instance of the class/inner class

### get\_loaded\_class

```gdscript
func get_loaded_class()
```

Can't call it get_class because that is reserved so it gets this ugly name.
Loads up the class and then any inner classes to give back a reference to
the desired Inner class (if there is any)

### to\_s

```gdscript
func to_s()
```

### get\_path

```gdscript
func get_path()
```

### get\_subpath

```gdscript
func get_subpath()
```

### has\_subpath

```gdscript
func has_subpath()
```

### get\_extends\_text

```gdscript
func get_extends_text()
```

### get\_method\_strategy

```gdscript
func get_method_strategy()
```

### set\_method\_strategy

```gdscript
func set_method_strategy(method_strategy)
```

### is\_native

```gdscript
func is_native()
```

### set\_native\_class

```gdscript
func set_native_class(native_class)
```

### get\_native\_class\_name

```gdscript
func get_native_class_name()
```

### FileOrString

#### Method Descriptions

### open

```gdscript
func open(path, mode)
```

### close

```gdscript
func close()
```

### store\_string

```gdscript
func store_string(s)
```

### get\_contents

```gdscript
func get_contents()
```

### get\_path

```gdscript
func get_path()
```

### load\_it

```gdscript
func load_it()
```

### PackedSceneDouble

#### Method Descriptions

### set\_script\_obj

```gdscript
func set_script_obj(obj)
```

### instance

```gdscript
func instance(edit_state = 0)
```

### load\_scene

```gdscript
func load_scene(path)
```

