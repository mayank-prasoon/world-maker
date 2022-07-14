<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# test\_collector.gd

## Property Descriptions

### scripts

```gdscript
var scripts
```

------------------------------------------------------------------------------
start test_collector, I don't think I like the name.
------------------------------------------------------------------------------

## Method Descriptions

### add\_script

```gdscript
func add_script(path)
```

-----------------
Public
-----------------

### clear

```gdscript
func clear()
```

### has\_script

```gdscript
func has_script(path)
```

### export\_tests

```gdscript
func export_tests(path)
```

### import\_tests

```gdscript
func import_tests(path)
```

### get\_script\_named

```gdscript
func get_script_named(name)
```

### get\_test\_named

```gdscript
func get_test_named(script_name, test_name)
```

### to\_s

```gdscript
func to_s()
```

### get\_logger

```gdscript
func get_logger()
```

---------------------
Accessors
---------------------

### set\_logger

```gdscript
func set_logger(logger)
```

### get\_test\_prefix

```gdscript
func get_test_prefix()
```

### set\_test\_prefix

```gdscript
func set_test_prefix(test_prefix)
```

### get\_test\_class\_prefix

```gdscript
func get_test_class_prefix()
```

### set\_test\_class\_prefix

```gdscript
func set_test_class_prefix(test_class_prefix)
```

## Sub\-classes

### Test

#### Property Descriptions

### passed

```gdscript
var passed
```

------------------------------------------------------------------------------
Used to keep track of info about each test ran.
------------------------------------------------------------------------------
indicator if it passed or not.  defaults to true since it takes only
one failure to make it not pass.  _fail in gut will set this.

### name

```gdscript
var name
```

------------------------------------------------------------------------------
Used to keep track of info about each test ran.
------------------------------------------------------------------------------
indicator if it passed or not.  defaults to true since it takes only
one failure to make it not pass.  _fail in gut will set this.
the name of the function

### has\_printed\_name

```gdscript
var has_printed_name
```

------------------------------------------------------------------------------
Used to keep track of info about each test ran.
------------------------------------------------------------------------------
indicator if it passed or not.  defaults to true since it takes only
one failure to make it not pass.  _fail in gut will set this.
the name of the function
flag to know if the name has been printed yet.

### arg\_count

```gdscript
var arg_count
```

------------------------------------------------------------------------------
Used to keep track of info about each test ran.
------------------------------------------------------------------------------
indicator if it passed or not.  defaults to true since it takes only
one failure to make it not pass.  _fail in gut will set this.
the name of the function
flag to know if the name has been printed yet.
the number of arguments the method has

### assert\_count

```gdscript
var assert_count
```

------------------------------------------------------------------------------
Used to keep track of info about each test ran.
------------------------------------------------------------------------------
indicator if it passed or not.  defaults to true since it takes only
one failure to make it not pass.  _fail in gut will set this.
the name of the function
flag to know if the name has been printed yet.
the number of arguments the method has
The number of asserts in the test

### pending

```gdscript
var pending
```

------------------------------------------------------------------------------
Used to keep track of info about each test ran.
------------------------------------------------------------------------------
indicator if it passed or not.  defaults to true since it takes only
one failure to make it not pass.  _fail in gut will set this.
the name of the function
flag to know if the name has been printed yet.
the number of arguments the method has
The number of asserts in the test
if the test has been marked pending at anypont during
execution.

### TestScript

#### Property Descriptions

### inner\_class\_name

```gdscript
var inner_class_name
```

------------------------------------------------------------------------------
This holds all the meta information for a test script.  It contains the
name of the inner class and an array of Test "structs".

This class also facilitates all the exporting and importing of tests.
------------------------------------------------------------------------------

### tests

```gdscript
var tests
```

### path

```gdscript
var path
```

#### Method Descriptions

### \_init

```gdscript
func _init(utils = null, logger = null)
```

### to\_s

```gdscript
func to_s()
```

### get\_new

```gdscript
func get_new()
```

### load\_script

```gdscript
func load_script()
```

### get\_filename\_and\_inner

```gdscript
func get_filename_and_inner()
```

### get\_full\_name

```gdscript
func get_full_name()
```

### get\_filename

```gdscript
func get_filename()
```

### has\_inner\_class

```gdscript
func has_inner_class()
```

### export\_to

```gdscript
func export_to(config_file, section)
```

Note:  although this no longer needs to export the inner_class names since
       they are pulled from metadata now, it is easier to leave that in
       so we don't have to cut the export down to unique script names.

### import\_from

```gdscript
func import_from(config_file, section)
```

### get\_test\_named

```gdscript
func get_test_named(name)
```

