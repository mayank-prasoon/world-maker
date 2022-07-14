<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# gut\_cmdln.gd

**Extends:** [SceneTree](../SceneTree)

## Description

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
Description
-----------
Command line interface for the GUT unit testing tool.  Allows you to run tests
from the command line instead of running a scene.  Place this script along with
gut.gd into your scripts directory at the root of your project.  Once there you
can run this script (from the root of your project) using the following command:
	godot -s -d test/gut/gut_cmdln.gd

See the readme for a list of options and examples.  You can also use the -gh
option to get more information about how to use the command line interface.
##############################################################################

## Property Descriptions

### Optparse

```gdscript
var Optparse
```

### Gut

```gdscript
var Gut
```

## Method Descriptions

### setup\_options

```gdscript
func setup_options(options, font_names)
```

### extract\_command\_line\_options

```gdscript
func extract_command_line_options(from, to)
```

Parses options, applying them to the _tester or setting values
in the options struct.

## Sub\-classes

### OptionResolver

#### Property Descriptions

### base\_opts

```gdscript
var base_opts
```

------------------------------------------------------------------------------
Helper class to resolve the various different places where an option can
be set.  Using the get_value method will enforce the order of precedence of:
	1.  command line value
	2.  config file value
	3.  default value

The idea is that you set the base_opts.  That will get you a copies of the
hash with null values for the other types of values.  Lower precedented hashes
will punch through null values of higher precedented hashes.
------------------------------------------------------------------------------

### cmd\_opts

```gdscript
var cmd_opts
```

### config\_opts

```gdscript
var config_opts
```

#### Method Descriptions

### get\_value

```gdscript
func get_value(key)
```

### set\_base\_opts

```gdscript
func set_base_opts(opts)
```

### to\_s

```gdscript
func to_s()
```

### get\_resolved\_values

```gdscript
func get_resolved_values()
```

### to\_s\_verbose

```gdscript
func to_s_verbose()
```

