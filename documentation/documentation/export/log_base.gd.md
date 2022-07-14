<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# log\_base.gd

**Extends:** [Node](../Node)

## Description

## Property Descriptions

### log\_file

```gdscript
var log_file
```

### persist\_debug

```gdscript
export var persist_debug = true
```

### logy

```gdscript
var logy
```

### file\_dir

```gdscript
export var file_dir = "user://"
```

### file\_name

```gdscript
export var file_name = "{dt}.log"
```

### file\_name\_time\_format

```gdscript
export var file_name_time_format = "{month}-{year}"
```

### formatting

```gdscript
export var formatting = "{dt} {level} {msg}"
```

### time\_format

```gdscript
export var time_format = "{month}/{day}/{year} {24hour}:{min}:{sec}"
```

### DEBUG

```gdscript
export var DEBUG = true
```

Allow toggling what you want

### INFO

```gdscript
export var INFO = true
```

Allow toggling what you want

### WARN

```gdscript
export var WARN = true
```

### ERROR

```gdscript
export var ERROR = true
```

### CRIT

```gdscript
export var CRIT = true
```

## Method Descriptions

### setup

```gdscript
func setup()
```

### pos2str

```gdscript
func pos2str(pos: Vector2 = "(0, 0)") -> String
```

Assistant Functions

### timestamp

```gdscript
func timestamp(fmat: String = "{month}/{day}/{year} {24hour}:{min}:{sec}", in_utc: bool = false)
```

### debug

```gdscript
func debug(msg: String)
```

### info

```gdscript
func info(msg: String)
```

### warn

```gdscript
func warn(msg: String)
```

### warning

```gdscript
func warning(msg: String)
```

### error

```gdscript
func error(msg: String, and_exit: bool = false)
```

### crit

```gdscript
func crit(msg: String, and_exit: bool = true)
```

### critical

```gdscript
func critical(msg: String, and_exit: bool = true)
```

