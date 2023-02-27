<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# optparse.gd

## Property Descriptions

### options

```gdscript
var options
```

-------------------------------------------------------------------------------
The high level interface between this script and the command line options
supplied.  Uses Option class and CmdLineParser to extract information from
the command line and make it easily accessible.
-------------------------------------------------------------------------------

## Method Descriptions

### add

```gdscript
func add(name, default, desc)
```

### get\_value

```gdscript
func get_value(name)
```

### set\_banner

```gdscript
func set_banner(banner)
```

### print\_help

```gdscript
func print_help()
```

### print\_options

```gdscript
func print_options()
```

### parse

```gdscript
func parse()
```

## Sub\-classes

### CmdLineParser

#### Method Descriptions

### find\_option

```gdscript
func find_option(name)
```

Search _opts for an element that starts with the option name
specified.

### get\_array\_value

```gdscript
func get_array_value(option)
```

### get\_value

```gdscript
func get_value(option)
```

returns the value of an option if it was specified, null otherwise.  This
used to return the default but that became problemnatic when trying to
punch through the different places where values could be specified.

### was\_specified

```gdscript
func was_specified(option)
```

returns true if it finds the option, false if not.

### get\_unused\_options

```gdscript
func get_unused_options()
```

Returns any unused command line options.  I found that only the -s and
script name come through from godot, all other options that godot uses
are not sent through OS.get_cmdline_args().

This is a onetime thing b/c i kill all items in _used_options

### Option

#### Property Descriptions

### value

```gdscript
var value
```

-------------------------------------------------------------------------------
Simple class to hold a command line option
-------------------------------------------------------------------------------

### option\_name

```gdscript
var option_name
```

### default

```gdscript
var default
```

### description

```gdscript
var description
```

#### Method Descriptions

### \_init

```gdscript
func _init(name, default_value, desc = "")
```

### pad

```gdscript
func pad(to_pad, size, pad_with = " ")
```

### to\_s

```gdscript
func to_s(min_space = 0)
```

