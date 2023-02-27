<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# signal\_watcher.gd

## Constants Descriptions

### ARG\_NOT\_SET

```gdscript
const ARG_NOT_SET: String = "_*_argument_*_is_*_not_set_*_"
```

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
Some arbitrary string that should never show up by accident.  If it does, then
shame on  you.

## Method Descriptions

### does\_object\_have\_signal

```gdscript
func does_object_have_signal(object, signal_name)
```

### watch\_signals

```gdscript
func watch_signals(object)
```

### watch\_signal

```gdscript
func watch_signal(object, signal_name)
```

### get\_emit\_count

```gdscript
func get_emit_count(object, signal_name)
```

### did\_emit

```gdscript
func did_emit(object, signal_name)
```

### print\_object\_signals

```gdscript
func print_object_signals(object)
```

### get\_signal\_parameters

```gdscript
func get_signal_parameters(object, signal_name, index = -1)
```

### is\_watching\_object

```gdscript
func is_watching_object(object)
```

### is\_watching

```gdscript
func is_watching(object, signal_name)
```

### clear

```gdscript
func clear()
```

### get\_signals\_emitted

```gdscript
func get_signals_emitted(obj)
```

Returns a list of all the signal names that were emitted by the object.
If the object is not being watched then an empty list is returned.