<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# stubber.gd

## Property Descriptions

### returns

```gdscript
var returns
```

-------------
returns{} and parameters {} have the followin structure
-------------
{
	inst_id_or_path1:{
		method_name1: [StubParams, StubParams],
		method_name2: [StubParams, StubParams]
	},
	inst_id_or_path2:{
		method_name1: [StubParams, StubParams],
		method_name2: [StubParams, StubParams]
	}
}

### parameters

```gdscript
var parameters
```

-------------
returns{} and parameters {} have the followin structure
-------------
{
	inst_id_or_path1:{
		method_name1: [StubParams, StubParams],
		method_name2: [StubParams, StubParams]
	},
	inst_id_or_path2:{
		method_name1: [StubParams, StubParams],
		method_name2: [StubParams, StubParams]
	}
}

## Method Descriptions

### set\_return

```gdscript
func set_return(obj, method, value, parameters = null)
```

##############
Public
##############
TODO: This method is only used in tests and should be refactored out.  It
does not support inner classes and isn't helpful.

### add\_stub

```gdscript
func add_stub(stub_params)
```

### get\_return

```gdscript
func get_return(obj, method, parameters = null)
```

Gets a stubbed return value for the object and method passed in.  If the
instance was stubbed it will use that, otherwise it will use the path and
subpath of the object to try to find a value.

It will also use the optional list of parameter values to find a value.  If
the object was stubbed with no parameters than any parameters will match.
If it was stubbed with specific parameter values then it will try to match.
If the parameters do not match BUT there was also an empty parameter list stub
then it will return those.
If it cannot find anything that matches then null is returned.for

Parameters
obj:  this should be an instance of a doubled object.
method:  the method called
parameters:  optional array of parameter vales to find a return value for.

### should\_call\_super

```gdscript
func should_call_super(obj, method, parameters = null)
```

### get\_parameter\_count

```gdscript
func get_parameter_count(obj, method)
```

### get\_default\_value

```gdscript
func get_default_value(obj, method, p_index)
```

### clear

```gdscript
func clear()
```

### get\_logger

```gdscript
func get_logger()
```

### set\_logger

```gdscript
func set_logger(logger)
```

### to\_s

```gdscript
func to_s()
```

