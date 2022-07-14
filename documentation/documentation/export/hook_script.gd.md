<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# hook\_script.gd

## Property Descriptions

### JunitXmlExport

```gdscript
var JunitXmlExport
```

------------------------------------------------------------------------------
This script is the base for custom scripts to be used in pre and post
run hooks.

To use, inherit from this script and then implement the run method.
------------------------------------------------------------------------------

### gut

```gdscript
var gut
```

This is the instance of GUT that is running the tests.  You can get
information about the run from this object.  This is set by GUT when the
script is instantiated.

## Method Descriptions

### run

```gdscript
func run()
```

Virtual method that will be called by GUT after instantiating
this script.

### set\_exit\_code

```gdscript
func set_exit_code(code)
```

Set the exit code when running from the command line.  If not set then the
default exit code will be returned (0 when no tests fail, 1 when any tests
fail).

### get\_exit\_code

```gdscript
func get_exit_code()
```

### abort

```gdscript
func abort()
```

Usable by pre-run script to cause the run to end AFTER the run() method
finishes.  post-run script will not be ran.

### should\_abort

```gdscript
func should_abort()
```

