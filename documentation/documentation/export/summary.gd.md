<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# summary.gd

## Method Descriptions

### add\_script

```gdscript
func add_script(name)
```

### get\_scripts

```gdscript
func get_scripts()
```

### get\_current\_script

```gdscript
func get_current_script()
```

### add\_test

```gdscript
func add_test(test_name)
```

### add\_pass

```gdscript
func add_pass(test_name, reason = "")
```

### add\_fail

```gdscript
func add_fail(test_name, reason = "")
```

### add\_pending

```gdscript
func add_pending(test_name, reason = "")
```

### get\_test\_text

```gdscript
func get_test_text(test_name)
```

### get\_non\_inner\_class\_script\_count

```gdscript
func get_non_inner_class_script_count()
```

Gets the count of unique script names minus the .<Inner Class Name> at the
end.  Used for displaying the number of scripts without including all the
Inner Classes.

### get\_totals

```gdscript
func get_totals()
```

### log\_summary\_text

```gdscript
func log_summary_text(lgr)
```

## Sub\-classes

### Test

#### Property Descriptions

### pass\_texts

```gdscript
var pass_texts
```

------------------------------------------------------------------------------
Contains all the results of a single test.  Allows for multiple asserts results
and pending calls.
------------------------------------------------------------------------------

### fail\_texts

```gdscript
var fail_texts
```

### pending\_texts

```gdscript
var pending_texts
```

### orphans

```gdscript
var orphans
```

#### Method Descriptions

### to\_s

```gdscript
func to_s()
```

NOTE:  The "failed" and "pending" text must match what is outputted by
the logger in order for text highlighting to occur in summary.

### get\_status

```gdscript
func get_status()
```

### TestScript

#### Property Descriptions

### name

```gdscript
var name
```

------------------------------------------------------------------------------
Contains all the results for a single test-script/inner class.  Persists the
names of the tests and results and the order in which  the tests were run.
------------------------------------------------------------------------------

#### Method Descriptions

### \_init

```gdscript
func _init(script_name)
```

### get\_pass\_count

```gdscript
func get_pass_count()
```

### get\_fail\_count

```gdscript
func get_fail_count()
```

### get\_pending\_count

```gdscript
func get_pending_count()
```

### get\_test\_obj

```gdscript
func get_test_obj(obj_name)
```

### add\_pass

```gdscript
func add_pass(test_name, reason)
```

### add\_fail

```gdscript
func add_fail(test_name, reason)
```

### add\_pending

```gdscript
func add_pending(test_name, reason)
```

### get\_tests

```gdscript
func get_tests()
```

