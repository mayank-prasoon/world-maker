<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# test.gd

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
View readme for usage details.

Version - see gut.gd
##############################################################################
Class that all test scripts must extend.

This provides all the asserts and other testing features.  Test scripts are
run by the Gut class in gut.gd
##############################################################################

## Constants Descriptions

### DEFAULT\_SETTER\_GETTER

```gdscript
const DEFAULT_SETTER_GETTER: int = 0
```

Used with assert_setget

### EDITOR\_PROPERTY

```gdscript
const EDITOR_PROPERTY: int = 8199
```

### GETTER\_ONLY

```gdscript
const GETTER_ONLY: int = 2
```

### SETTER\_ONLY

```gdscript
const SETTER_ONLY: int = 1
```

### VARIABLE\_PROPERTY

```gdscript
const VARIABLE_PROPERTY: int = 8192
```

### YIELD

```gdscript
const YIELD: String = "timeout"
```

constant for signal when calling yield_for

## Property Descriptions

### gut

```gdscript
var gut
```

Need a reference to the instance that is running the tests.  This
is set by the gut class when it runs the tests.  This gets you
access to the asserts in the tests you write.

### DOUBLE\_STRATEGY

```gdscript
var DOUBLE_STRATEGY
```

Convenience copy of _utils.DOUBLE_STRATEGY

### ParameterFactory

```gdscript
var ParameterFactory
```

syntax sugar

### CompareResult

```gdscript
var CompareResult
```

syntax sugar

## Method Descriptions

### before\_all

```gdscript
func before_all()
```

#######################
Virtual Methods
#######################
alias for prerun_setup

### before\_each

```gdscript
func before_each()
```

alias for setup

### after\_all

```gdscript
func after_all()
```

alias for postrun_teardown

### after\_each

```gdscript
func after_each()
```

alias for teardown

### get\_logger

```gdscript
func get_logger()
```

#######################
Public
#######################

### set\_logger

```gdscript
func set_logger(logger)
```

### assert\_eq

```gdscript
func assert_eq(got, expected, text = "")
```

#######################
Asserts
#######################
------------------------------------------------------------------------------
Asserts that the expected value equals the value got.
------------------------------------------------------------------------------

### assert\_ne

```gdscript
func assert_ne(got, not_expected, text = "")
```

------------------------------------------------------------------------------
Asserts that the value got does not equal the "not expected" value.
------------------------------------------------------------------------------

### assert\_almost\_eq

```gdscript
func assert_almost_eq(got, expected, error_interval, text = "")
```

------------------------------------------------------------------------------
Asserts that the expected value almost equals the value got.
------------------------------------------------------------------------------

### assert\_almost\_ne

```gdscript
func assert_almost_ne(got, not_expected, error_interval, text = "")
```

------------------------------------------------------------------------------
Asserts that the expected value does not almost equal the value got.
------------------------------------------------------------------------------

### assert\_gt

```gdscript
func assert_gt(got, expected, text = "")
```

------------------------------------------------------------------------------
Asserts got is greater than expected
------------------------------------------------------------------------------

### assert\_lt

```gdscript
func assert_lt(got, expected, text = "")
```

------------------------------------------------------------------------------
Asserts got is less than expected
------------------------------------------------------------------------------

### assert\_true

```gdscript
func assert_true(got, text = "")
```

------------------------------------------------------------------------------
asserts that got is true
------------------------------------------------------------------------------

### assert\_false

```gdscript
func assert_false(got, text = "")
```

------------------------------------------------------------------------------
Asserts that got is false
------------------------------------------------------------------------------

### assert\_between

```gdscript
func assert_between(got, expect_low, expect_high, text = "")
```

------------------------------------------------------------------------------
Asserts value is between (inclusive) the two expected values.
------------------------------------------------------------------------------

### assert\_not\_between

```gdscript
func assert_not_between(got, expect_low, expect_high, text = "")
```

------------------------------------------------------------------------------
Asserts value is not between (exclusive) the two expected values.
------------------------------------------------------------------------------

### assert\_has

```gdscript
func assert_has(obj, element, text = "")
```

------------------------------------------------------------------------------
Uses the 'has' method of the object passed in to determine if it contains
the passed in element.
------------------------------------------------------------------------------

### assert\_does\_not\_have

```gdscript
func assert_does_not_have(obj, element, text = "")
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### assert\_file\_exists

```gdscript
func assert_file_exists(file_path)
```

------------------------------------------------------------------------------
Asserts that a file exists
------------------------------------------------------------------------------

### assert\_file\_does\_not\_exist

```gdscript
func assert_file_does_not_exist(file_path)
```

------------------------------------------------------------------------------
Asserts that a file should not exist
------------------------------------------------------------------------------

### assert\_file\_empty

```gdscript
func assert_file_empty(file_path)
```

------------------------------------------------------------------------------
Asserts the specified file is empty
------------------------------------------------------------------------------

### assert\_file\_not\_empty

```gdscript
func assert_file_not_empty(file_path)
```

------------------------------------------------------------------------------
Asserts the specified file is not empty
------------------------------------------------------------------------------

### assert\_has\_method

```gdscript
func assert_has_method(obj, method)
```

------------------------------------------------------------------------------
Asserts the object has the specified method
------------------------------------------------------------------------------

### assert\_get\_set\_methods

```gdscript
func assert_get_set_methods(obj, property, default, set_to)
```

Old deprecated method name

### assert\_accessors

```gdscript
func assert_accessors(obj, property, default, set_to)
```

------------------------------------------------------------------------------
Verifies the object has get and set methods for the property passed in.  The
property isn't tied to anything, just a name to be appended to the end of
get_ and set_.  Asserts the get_ and set_ methods exist, if not, it stops there.
If they exist then it asserts get_ returns the expected default then calls
set_ and asserts get_ has the value it was set to.
------------------------------------------------------------------------------

### assert\_exports

```gdscript
func assert_exports(obj, property_name, type)
```

------------------------------------------------------------------------------
Asserts a class exports a variable.
------------------------------------------------------------------------------

### watch\_signals

```gdscript
func watch_signals(object)
```

------------------------------------------------------------------------------
Watch the signals for an object.  This must be called before you can make
any assertions about the signals themselves.
------------------------------------------------------------------------------

### assert\_connected

```gdscript
func assert_connected(signaler_obj, connect_to_obj, signal_name, method_name = "")
```

------------------------------------------------------------------------------
Asserts that an object is connected to a signal on another object

This will fail with specific messages if the target object is not connected
to the specified signal on the source object.
------------------------------------------------------------------------------

### assert\_not\_connected

```gdscript
func assert_not_connected(signaler_obj, connect_to_obj, signal_name, method_name = "")
```

------------------------------------------------------------------------------
Asserts that an object is not connected to a signal on another object

This will fail with specific messages if the target object is connected
to the specified signal on the source object.
------------------------------------------------------------------------------

### assert\_signal\_emitted

```gdscript
func assert_signal_emitted(object, signal_name, text = "")
```

------------------------------------------------------------------------------
Asserts that a signal has been emitted at least once.

This will fail with specific messages if the object is not being watched or
the object does not have the specified signal
------------------------------------------------------------------------------

### assert\_signal\_not\_emitted

```gdscript
func assert_signal_not_emitted(object, signal_name, text = "")
```

------------------------------------------------------------------------------
Asserts that a signal has not been emitted.

This will fail with specific messages if the object is not being watched or
the object does not have the specified signal
------------------------------------------------------------------------------

### assert\_signal\_emitted\_with\_parameters

```gdscript
func assert_signal_emitted_with_parameters(object, signal_name, parameters, index = -1)
```

------------------------------------------------------------------------------
Asserts that a signal was fired with the specified parameters.  The expected
parameters should be passed in as an array.  An optional index can be passed
when a signal has fired more than once.  The default is to retrieve the most
recent emission of the signal.

This will fail with specific messages if the object is not being watched or
the object does not have the specified signal
------------------------------------------------------------------------------

### assert\_signal\_emit\_count

```gdscript
func assert_signal_emit_count(object, signal_name, times, text = "")
```

------------------------------------------------------------------------------
Assert that a signal has been emitted a specific number of times.

This will fail with specific messages if the object is not being watched or
the object does not have the specified signal
------------------------------------------------------------------------------

### assert\_has\_signal

```gdscript
func assert_has_signal(object, signal_name, text = "")
```

------------------------------------------------------------------------------
Assert that the passed in object has the specified signal
------------------------------------------------------------------------------

### get\_signal\_emit\_count

```gdscript
func get_signal_emit_count(object, signal_name)
```

------------------------------------------------------------------------------
Returns the number of times a signal was emitted.  -1 returned if the object
is not being watched.
------------------------------------------------------------------------------

### get\_signal\_parameters

```gdscript
func get_signal_parameters(object, signal_name, index = -1)
```

------------------------------------------------------------------------------
Get the parmaters of a fired signal.  If the signal was not fired null is
returned.  You can specify an optional index (use get_signal_emit_count to
determine the number of times it was emitted).  The default index is the
latest time the signal was fired (size() -1 insetead of 0).  The parameters
returned are in an array.
------------------------------------------------------------------------------

### get\_call\_parameters

```gdscript
func get_call_parameters(object, method_name, index = -1)
```

------------------------------------------------------------------------------
Get the parameters for a method call to a doubled object.  By default it will
return the most recent call.  You can optionally specify an index.

Returns:
* an array of parameter values if a call the method was found
* null when a call to the method was not found or the index specified was
  invalid.
------------------------------------------------------------------------------

### get\_call\_count

```gdscript
func get_call_count(object, method_name, parameters = null)
```

------------------------------------------------------------------------------
Returns the call count for a method with optional paramter matching.
------------------------------------------------------------------------------

### assert\_extends

```gdscript
func assert_extends(object, a_class, text = "")
```

------------------------------------------------------------------------------
Assert that object is an instance of a_class
------------------------------------------------------------------------------

### assert\_is

```gdscript
func assert_is(object, a_class, text = "")
```

Alias for assert_extends

### assert\_typeof

```gdscript
func assert_typeof(object, type, text = "")
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### assert\_not\_typeof

```gdscript
func assert_not_typeof(object, type, text = "")
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### assert\_string\_contains

```gdscript
func assert_string_contains(text, search, match_case = true)
```

------------------------------------------------------------------------------
Assert that text contains given search string.
The match_case flag determines case sensitivity.
------------------------------------------------------------------------------

### assert\_string\_starts\_with

```gdscript
func assert_string_starts_with(text, search, match_case = true)
```

------------------------------------------------------------------------------
Assert that text starts with given search string.
match_case flag determines case sensitivity.
------------------------------------------------------------------------------

### assert\_string\_ends\_with

```gdscript
func assert_string_ends_with(text, search, match_case = true)
```

------------------------------------------------------------------------------
Assert that text ends with given search string.
match_case flag determines case sensitivity.
------------------------------------------------------------------------------

### assert\_called

```gdscript
func assert_called(inst, method_name, parameters = null)
```

------------------------------------------------------------------------------
Assert that a method was called on an instance of a doubled class.  If
parameters are supplied then the params passed in when called must match.
TODO make 3rd parameter "param_or_text" and add fourth parameter of "text" and
     then work some magic so this can have a "text" parameter without being
     annoying.
------------------------------------------------------------------------------

### assert\_not\_called

```gdscript
func assert_not_called(inst, method_name, parameters = null)
```

------------------------------------------------------------------------------
Assert that a method was not called on an instance of a doubled class.  If
parameters are specified then this will only fail if it finds a call that was
sent matching parameters.
------------------------------------------------------------------------------

### assert\_call\_count

```gdscript
func assert_call_count(inst, method_name, expected_count, parameters = null)
```

------------------------------------------------------------------------------
Assert that a method on an instance of a doubled class was called a number
of times.  If parameters are specified then only calls with matching
parameter values will be counted.
------------------------------------------------------------------------------

### assert\_null

```gdscript
func assert_null(got, text = "")
```

------------------------------------------------------------------------------
Asserts the passed in value is null
------------------------------------------------------------------------------

### assert\_not\_null

```gdscript
func assert_not_null(got, text = "")
```

------------------------------------------------------------------------------
Asserts the passed in value is null
------------------------------------------------------------------------------

### assert\_freed

```gdscript
func assert_freed(obj, title)
```

-----------------------------------------------------------------------------
Asserts object has been freed from memory
We pass in a title (since if it is freed, we lost all identity data)
-----------------------------------------------------------------------------

### assert\_not\_freed

```gdscript
func assert_not_freed(obj, title)
```

------------------------------------------------------------------------------
Asserts Object has not been freed from memory
-----------------------------------------------------------------------------

### assert\_no\_new\_orphans

```gdscript
func assert_no_new_orphans(text = "")
```

------------------------------------------------------------------------------
Asserts that the current test has not introduced any new orphans.  This only
applies to the test code that preceedes a call to this method so it should be
the last thing your test does.
------------------------------------------------------------------------------

### assert\_setget

```gdscript
func assert_setget(instance, name_property, const_or_setter, getter = "__not_set__")
```

------------------------------------------------------------------------------
Wrapper: invokes assert_setget_called but provides a slightly more convenient
signature
------------------------------------------------------------------------------

### assert\_property

```gdscript
func assert_property(instance, name_property, default_value, new_value) -> void
```

------------------------------------------------------------------------------
Wrapper: asserts if the property exists, the accessor methods exist and the
setget keyword is set for accessor methods
------------------------------------------------------------------------------

### pending

```gdscript
func pending(text = "")
```

------------------------------------------------------------------------------
Mark the current test as pending.
------------------------------------------------------------------------------

### yield\_for

```gdscript
func yield_for(time, msg = "")
```

------------------------------------------------------------------------------
Yield for the time sent in.  The optional message will be printed when
Gut detects the yield.  When the time expires the YIELD signal will be
emitted.
------------------------------------------------------------------------------

### yield\_to

```gdscript
func yield_to(obj, signal_name, max_wait, msg = "")
```

------------------------------------------------------------------------------
Yield to a signal or a maximum amount of time, whichever comes first.  When
the conditions are met the YIELD signal will be emitted.
------------------------------------------------------------------------------

### yield\_frames

```gdscript
func yield_frames(frames, msg = "")
```

------------------------------------------------------------------------------
Yield for a number of frames.  The optional message will be printed. when
Gut detects a yield.  When the number of frames have elapsed (counted in gut's
_process function) the YIELD signal will be emitted.
------------------------------------------------------------------------------

### end\_test

```gdscript
func end_test()
```

------------------------------------------------------------------------------
Ends a test that had a yield in it.  You only need to use this if you do
not make assertions after a yield.
------------------------------------------------------------------------------

### get\_summary

```gdscript
func get_summary()
```

gut.end_yielded_test()

### get\_fail\_count

```gdscript
func get_fail_count()
```

### get\_pass\_count

```gdscript
func get_pass_count()
```

### get\_pending\_count

```gdscript
func get_pending_count()
```

### get\_assert\_count

```gdscript
func get_assert_count()
```

### clear\_signal\_watcher

```gdscript
func clear_signal_watcher()
```

### get\_double\_strategy

```gdscript
func get_double_strategy()
```

### set\_double\_strategy

```gdscript
func set_double_strategy(double_strategy)
```

### pause\_before\_teardown

```gdscript
func pause_before_teardown()
```

### get\_summary\_text

```gdscript
func get_summary_text()
```

------------------------------------------------------------------------------
Convert the _summary dictionary into text
------------------------------------------------------------------------------

### double

```gdscript
func double(thing, p2 = null, p3 = null)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### partial\_double

```gdscript
func partial_double(thing, p2 = null, p3 = null)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### double\_scene

```gdscript
func double_scene(path, strategy = null)
```

------------------------------------------------------------------------------
Specifically double a scene
------------------------------------------------------------------------------

### double\_script

```gdscript
func double_script(path, strategy = null)
```

------------------------------------------------------------------------------
Specifically double a script
------------------------------------------------------------------------------

### double\_inner

```gdscript
func double_inner(path, subpath, strategy = null)
```

------------------------------------------------------------------------------
Specifically double an Inner class in a a script
------------------------------------------------------------------------------

### ignore\_method\_when\_doubling

```gdscript
func ignore_method_when_doubling(thing, method_name)
```

------------------------------------------------------------------------------
Add a method that the doubler will ignore.  You can pass this the path to a
script or scene or a loaded script or scene.  When running tests, these
ignores are cleared after every test.
------------------------------------------------------------------------------

### stub

```gdscript
func stub(thing, p2, p3 = null)
```

------------------------------------------------------------------------------
Stub something.

Parameters
1: the thing to stub, a file path or a instance or a class
2: either an inner class subpath or the method name
3: the method name if an inner class subpath was specified
NOTE:  right now we cannot stub inner classes at the path level so this should
       only be called with two parameters.  I did the work though so I'm going
       to leave it but not update the wiki.
------------------------------------------------------------------------------

### simulate

```gdscript
func simulate(obj, times, delta)
```

------------------------------------------------------------------------------
convenience wrapper.
------------------------------------------------------------------------------

### replace\_node

```gdscript
func replace_node(base_node, path_or_node, with_this)
```

------------------------------------------------------------------------------
Replace the node at base_node.get_node(path) with with_this.  All references
to the node via $ and get_node(...) will now return with_this.  with_this will
get all the groups that the node that was replaced had.

The node that was replaced is queued to be freed.

TODO see replace_by method, this could simplify the logic here.
------------------------------------------------------------------------------

### use\_parameters

```gdscript
func use_parameters(params)
```

------------------------------------------------------------------------------
This method does a somewhat complicated dance with Gut.  It assumes that Gut
will clear its parameter handler after it finishes calling a parameterized test
enough times.
------------------------------------------------------------------------------

### autofree

```gdscript
func autofree(thing)
```

------------------------------------------------------------------------------
Marks whatever is passed in to be freed after the test finishes.  It also
returns what is passed in so you can save a line of code.
  var thing = autofree(Thing.new())
------------------------------------------------------------------------------

### autoqfree

```gdscript
func autoqfree(thing)
```

------------------------------------------------------------------------------
Works the same as autofree except queue_free will be called on the object
instead.  This also imparts a brief pause after the test finishes so that
the queued object has time to free.
------------------------------------------------------------------------------

### add\_child\_autofree

```gdscript
func add_child_autofree(node, legible_unique_name = false)
```

------------------------------------------------------------------------------
The same as autofree but it also adds the object as a child of the test.
------------------------------------------------------------------------------

### add\_child\_autoqfree

```gdscript
func add_child_autoqfree(node, legible_unique_name = false)
```

------------------------------------------------------------------------------
The same as autoqfree but it also adds the object as a child of the test.
------------------------------------------------------------------------------

### is\_passing

```gdscript
func is_passing()
```

------------------------------------------------------------------------------
Returns true if the test is passing as of the time of this call.  False if not.
------------------------------------------------------------------------------

### is\_failing

```gdscript
func is_failing()
```

------------------------------------------------------------------------------
Returns true if the test is failing as of the time of this call.  False if not.
------------------------------------------------------------------------------

### pass\_test

```gdscript
func pass_test(text)
```

------------------------------------------------------------------------------
Marks the test as passing.  Does not override any failing asserts or calls to
fail_test.  Same as a passing assert.
------------------------------------------------------------------------------

### fail\_test

```gdscript
func fail_test(text)
```

------------------------------------------------------------------------------
Marks the test as failing.  Same as a failing assert.
------------------------------------------------------------------------------

### compare\_deep

```gdscript
func compare_deep(v1, v2, max_differences = null)
```

------------------------------------------------------------------------------
Peforms a deep compare on both values, a CompareResult instnace is returned.
The optional max_differences paramter sets the max_differences to be displayed.
------------------------------------------------------------------------------

### compare\_shallow

```gdscript
func compare_shallow(v1, v2, max_differences = null)
```

------------------------------------------------------------------------------
Peforms a shallow compare on both values, a CompareResult instnace is returned.
The optional max_differences paramter sets the max_differences to be displayed.
------------------------------------------------------------------------------

### assert\_eq\_deep

```gdscript
func assert_eq_deep(v1, v2)
```

------------------------------------------------------------------------------
Performs a deep compare and asserts the  values are equal
------------------------------------------------------------------------------

### assert\_ne\_deep

```gdscript
func assert_ne_deep(v1, v2)
```

------------------------------------------------------------------------------
Performs a deep compare and asserts the values are not equal
------------------------------------------------------------------------------

### assert\_eq\_shallow

```gdscript
func assert_eq_shallow(v1, v2)
```

------------------------------------------------------------------------------
Performs a shallow compare and asserts the values are equal
------------------------------------------------------------------------------

### assert\_ne\_shallow

```gdscript
func assert_ne_shallow(v1, v2)
```

------------------------------------------------------------------------------
Performs a shallow compare and asserts the values are not equal
------------------------------------------------------------------------------

## Sub\-classes

### DoubleInfo

#### Property Descriptions

### path

```gdscript
var path
```

------------------------------------------------------------------------------
Helper class to hold info for objects to double.  This extracts info and has
some convenience methods.  This is key in being able to make the "smart double"
method which makes doubling much easier for the user.
------------------------------------------------------------------------------

### subpath

```gdscript
var subpath
```

### strategy

```gdscript
var strategy
```

### make\_partial

```gdscript
var make_partial
```

### extension

```gdscript
var extension
```

### is\_valid

```gdscript
var is_valid
```

#### Method Descriptions

### \_init

```gdscript
func _init(thing, p2 = null, p3 = null)
```

Flexible init method.  p2 can be subpath or stategy unless p3 is
specified, then p2 must be subpath and p3 is strategy.

Examples:
  (object_to_double)
  (object_to_double, subpath)
  (object_to_double, strategy)
  (object_to_double, subpath, strategy)

### is\_scene

```gdscript
func is_scene()
```

### is\_script

```gdscript
func is_script()
```

### is\_native

```gdscript
func is_native()
```

