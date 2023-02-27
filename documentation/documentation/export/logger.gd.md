<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# logger.gd

## Property Descriptions

### types

```gdscript
var types
```

##############################################################################
(G)odot (U)nit (T)est class

##############################################################################
The MIT License (MIT)
=====================

Copyright (c) 2020 Tom "Butch" Wesley

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

##############################################################################
This class wraps around the various printers and supplies formatting for the
various message types (error, warning, etc).
##############################################################################

### fmts

```gdscript
var fmts
```

## Method Descriptions

### get\_indent\_text

```gdscript
func get_indent_text()
```

### get\_warnings

```gdscript
func get_warnings()
```

---------------
Get Methods
---------------

### get\_errors

```gdscript
func get_errors()
```

### get\_infos

```gdscript
func get_infos()
```

### get\_debugs

```gdscript
func get_debugs()
```

### get\_deprecated

```gdscript
func get_deprecated()
```

### get\_count

```gdscript
func get_count(log_type = null)
```

### get\_log\_entries

```gdscript
func get_log_entries(log_type)
```

### debug

```gdscript
func debug(text)
```

### deprecated

```gdscript
func deprecated(text, alt_method = null)
```

supply some text or the name of the deprecated method and the replacement.

### error

```gdscript
func error(text)
```

### failed

```gdscript
func failed(text)
```

### info

```gdscript
func info(text)
```

### orphan

```gdscript
func orphan(text)
```

### passed

```gdscript
func passed(text)
```

### pending

```gdscript
func pending(text)
```

### warn

```gdscript
func warn(text)
```

### log

```gdscript
func log(text = "", fmt)
```

### lograw

```gdscript
func lograw(text, fmt)
```

### log\_test\_name

```gdscript
func log_test_name()
```

Print the test name if we aren't skipping names of tests that pass (basically
what _less_test_names means))

### get\_gut

```gdscript
func get_gut()
```

---------------
Misc
---------------

### set\_gut

```gdscript
func set_gut(gut)
```

### get\_indent\_level

```gdscript
func get_indent_level()
```

### set\_indent\_level

```gdscript
func set_indent_level(indent_level)
```

### get\_indent\_string

```gdscript
func get_indent_string()
```

### set\_indent\_string

```gdscript
func set_indent_string(indent_string)
```

### clear

```gdscript
func clear()
```

### inc\_indent

```gdscript
func inc_indent()
```

### dec\_indent

```gdscript
func dec_indent()
```

### is\_type\_enabled

```gdscript
func is_type_enabled(type)
```

### set\_type\_enabled

```gdscript
func set_type_enabled(type, is_enabled)
```

### get\_less\_test\_names

```gdscript
func get_less_test_names()
```

### set\_less\_test\_names

```gdscript
func set_less_test_names(less_test_names)
```

### disable\_printer

```gdscript
func disable_printer(name, is_disabled)
```

### is\_printer\_disabled

```gdscript
func is_printer_disabled(name)
```

### disable\_formatting

```gdscript
func disable_formatting(is_disabled)
```

### get\_printer

```gdscript
func get_printer(printer_key)
```

### yield\_text

```gdscript
func yield_text(text)
```

### end\_yield

```gdscript
func end_yield()
```

