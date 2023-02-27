<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# utils.gd

**Extends:** [Node](../Node)

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
This class is a PSUEDO SINGLETON.  You should not make instances of it but use
the get_instance static method.
##############################################################################

## Enumerations

### DOUBLE\_STRATEGY

```gdscript
const DOUBLE_STRATEGY: Dictionary = {"FULL":0,"PARTIAL":1}
```

### DIFF

```gdscript
const DIFF: Dictionary = {"DEEP":0,"SHALLOW":1,"SIMPLE":2}
```

## Constants Descriptions

### GUT\_METADATA

```gdscript
const GUT_METADATA: String = "__gut_metadata_"
```

## Property Descriptions

### Logger

```gdscript
var Logger
```

everything should use get_logger

### AutoFree

```gdscript
var AutoFree
```

### Comparator

```gdscript
var Comparator
```

### CompareResult

```gdscript
var CompareResult
```

### DiffTool

```gdscript
var DiffTool
```

### Doubler

```gdscript
var Doubler
```

### Gut

```gdscript
var Gut
```

### HookScript

```gdscript
var HookScript
```

### JunitXmlExport

```gdscript
var JunitXmlExport
```

### MethodMaker

```gdscript
var MethodMaker
```

### OneToMany

```gdscript
var OneToMany
```

### OrphanCounter

```gdscript
var OrphanCounter
```

### ParameterFactory

```gdscript
var ParameterFactory
```

### ParameterHandler

```gdscript
var ParameterHandler
```

### Printers

```gdscript
var Printers
```

### ResultExporter

```gdscript
var ResultExporter
```

### Spy

```gdscript
var Spy
```

### Strutils

```gdscript
var Strutils
```

### Stubber

```gdscript
var Stubber
```

### StubParams

```gdscript
var StubParams
```

### Summary

```gdscript
var Summary
```

### Test

```gdscript
var Test
```

### TestCollector

```gdscript
var TestCollector
```

### ThingCounter

```gdscript
var ThingCounter
```

### version

```gdscript
var version
```

Source of truth for the GUT version

### req\_godot

```gdscript
var req_godot
```

Source of truth for the GUT version
The required Godot version as an array.

### latest\_version

```gdscript
var latest_version
```

Source of truth for the GUT version
The required Godot version as an array.
Used for doing file manipulation stuff so as to not keep making File instances.
could be a bit of overkill but who cares.
Online fetch of the latest version available on github

### should\_display\_latest\_version

```gdscript
var should_display_latest_version
```

Source of truth for the GUT version
The required Godot version as an array.
Used for doing file manipulation stuff so as to not keep making File instances.
could be a bit of overkill but who cares.
Online fetch of the latest version available on github

## Method Descriptions

### get\_version\_text

```gdscript
func get_version_text()
```

------------------------------------------------------------------------------
Blurb of text with GUT and Godot versions.
------------------------------------------------------------------------------

### get\_bad\_version\_text

```gdscript
func get_bad_version_text()
```

------------------------------------------------------------------------------
Returns a nice string for erroring out when we have a bad Godot version.
------------------------------------------------------------------------------

### is\_version\_ok

```gdscript
func is_version_ok(engine_info, required)
```

------------------------------------------------------------------------------
Checks the Godot version against req_godot array.
------------------------------------------------------------------------------

### get\_logger

```gdscript
func get_logger()
```

------------------------------------------------------------------------------
Everything should get a logger through this.

When running in test mode this will always return a new logger so that errors
are not caused by getting bad warn/error/etc counts.
------------------------------------------------------------------------------

### nvl

```gdscript
func nvl(value, if_null)
```

------------------------------------------------------------------------------
return if_null if value is null otherwise return value
------------------------------------------------------------------------------

### is\_freed

```gdscript
func is_freed(obj)
```

------------------------------------------------------------------------------
returns true if the object has been freed, false if not

From what i've read, the weakref approach should work.  It seems to work most
of the time but sometimes it does not catch it.  The str comparison seems to
fill in the gaps.  I've not seen any errors after adding that check.
------------------------------------------------------------------------------

### is\_not\_freed

```gdscript
func is_not_freed(obj)
```

------------------------------------------------------------------------------
Pretty self explanitory.
------------------------------------------------------------------------------

### is\_double

```gdscript
func is_double(obj)
```

------------------------------------------------------------------------------
Checks if the passed in object is a GUT Double or Partial Double.
------------------------------------------------------------------------------

### is\_instance

```gdscript
func is_instance(obj)
```

------------------------------------------------------------------------------
Checks if the passed in is an instance of a class
------------------------------------------------------------------------------

### is\_gdscript

```gdscript
func is_gdscript(obj)
```

------------------------------------------------------------------------------
Checks if the passed in is a GDScript
------------------------------------------------------------------------------

### extract\_property\_from\_array

```gdscript
func extract_property_from_array(source, property)
```

------------------------------------------------------------------------------
Returns an array of values by calling get(property) on each element in source
------------------------------------------------------------------------------

### file\_exists

```gdscript
func file_exists(path)
```

------------------------------------------------------------------------------
true if file exists, false if not.
------------------------------------------------------------------------------

### write\_file

```gdscript
func write_file(path, content)
```

------------------------------------------------------------------------------
Write a file.
------------------------------------------------------------------------------

### is\_null\_or\_empty

```gdscript
func is_null_or_empty(text)
```

------------------------------------------------------------------------------
true if what is passed in is null or an empty string.
------------------------------------------------------------------------------

### get\_native\_class\_name

```gdscript
func get_native_class_name(thing)
```

------------------------------------------------------------------------------
Get the name of a native class or null if the object passed in is not a
native class.
------------------------------------------------------------------------------

### is\_native\_class

```gdscript
func is_native_class(thing)
```

------------------------------------------------------------------------------
Checks an object to see if it is a GDScriptNativeClass
------------------------------------------------------------------------------

### get\_file\_as\_text

```gdscript
func get_file_as_text(path)
```

------------------------------------------------------------------------------
Returns the text of a file or an empty string if the file could not be opened.
------------------------------------------------------------------------------

### search\_array

```gdscript
func search_array(ar, prop_method, value)
```

------------------------------------------------------------------------------
Loops through an array of things and calls a method or checks a property on
each element until it finds the returned value.  The item in the array is
returned or null if it is not found.
------------------------------------------------------------------------------

### are\_datatypes\_same

```gdscript
func are_datatypes_same(got, expected)
```

### pretty\_print

```gdscript
func pretty_print(dict)
```

### get\_script\_text

```gdscript
func get_script_text(obj)
```

### INSTANCE\_NAME <small>(static)</small>

```gdscript
func INSTANCE_NAME()
```

------------------------------------------------------------------------------
The instance name as a function since you can't have static variables.
------------------------------------------------------------------------------

### get\_root\_node <small>(static)</small>

```gdscript
func get_root_node()
```

------------------------------------------------------------------------------
Gets the root node without having to be in the tree and pushing out an error
if we don't have a main loop ready to go yet.
------------------------------------------------------------------------------

### get\_instance <small>(static)</small>

```gdscript
func get_instance()
```

------------------------------------------------------------------------------
Get the ONE instance of utils
------------------------------------------------------------------------------