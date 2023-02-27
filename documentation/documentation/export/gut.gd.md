<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# gut.gd

**Extends:** [Control](../Control)

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
View the readme at https://github.com/bitwes/Gut/blob/master/README.md for usage details.
You should also check out the github wiki at: https://github.com/bitwes/Gut/wiki
##############################################################################

## Constants Descriptions

### COMPLETED

```gdscript
const COMPLETED: String = "completed"
```

### LOG\_LEVEL\_ALL\_ASSERTS

```gdscript
const LOG_LEVEL_ALL_ASSERTS: int = 2
```

### LOG\_LEVEL\_FAIL\_ONLY

```gdscript
const LOG_LEVEL_FAIL_ONLY: int = 0
```

###########################
Other Vars
###########################

### LOG\_LEVEL\_TEST\_AND\_FAILURES

```gdscript
const LOG_LEVEL_TEST_AND_FAILURES: int = 1
```

###########################
Other Vars
###########################

### PAUSE\_MESSAGE

```gdscript
const PAUSE_MESSAGE: String = "/# Pausing.  Press continue button...#/"
```

Pausing.  Press continue button...#/'

### SIGNAL\_STOP\_YIELD\_BEFORE\_TEARDOWN

```gdscript
const SIGNAL_STOP_YIELD_BEFORE_TEARDOWN: String = "stop_yield_before_teardown"
```

### SIGNAL\_TESTS\_FINISHED

```gdscript
const SIGNAL_TESTS_FINISHED: String = "tests_finished"
```

### WAITING\_MESSAGE

```gdscript
const WAITING_MESSAGE: String = "/# waiting #/"
```

waiting #/'

## Method Descriptions

### p

```gdscript
func p(text, level = 0, NOT_USED_ANYMORE = -123)
```

########################

public

########################
------------------------------------------------------------------------------
Conditionally prints the text to the console/results variable based on the
current log level and what level is passed in.  Whenever currently in a test,
the text will be indented under the test.  It can be further indented if
desired.

The first time output is generated when in a test, the test name will be
printed.

NOT_USED_ANYMORE was indent level.  This was deprecated in 7.0.0.
------------------------------------------------------------------------------

### get\_minimum\_size

```gdscript
func get_minimum_size()
```

###############

RUN TESTS/ADD SCRIPTS

###############

### test\_scripts

```gdscript
func test_scripts(run_rest = false)
```

------------------------------------------------------------------------------
Runs all the scripts that were added using add_script
------------------------------------------------------------------------------

### run\_tests

```gdscript
func run_tests(run_rest = false)
```

alias

### test\_script

```gdscript
func test_script(script)
```

------------------------------------------------------------------------------
Runs a single script passed in.
------------------------------------------------------------------------------

### add\_script

```gdscript
func add_script(script)
```

------------------------------------------------------------------------------
Adds a script to be run when test_scripts called.
------------------------------------------------------------------------------

### add\_directory

```gdscript
func add_directory(path, prefix, suffix)
```

------------------------------------------------------------------------------
Add all scripts in the specified directory that start with the prefix and end
with the suffix.  Does not look in sub directories.  Can be called multiple
times.
------------------------------------------------------------------------------

### select\_script

```gdscript
func select_script(script_name)
```

------------------------------------------------------------------------------
This will try to find a script in the list of scripts to test that contains
the specified script name.  It does not have to be a full match.  It will
select the first matching occurrence so that this script will run when run_tests
is called.  Works the same as the select_this_one option of add_script.

returns whether it found a match or not
------------------------------------------------------------------------------

### export\_tests

```gdscript
func export_tests(path)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### import\_tests

```gdscript
func import_tests(path)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### import\_tests\_if\_none\_found

```gdscript
func import_tests_if_none_found()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### export\_if\_tests\_found

```gdscript
func export_if_tests_found()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### set\_should\_maximize

```gdscript
func set_should_maximize(should)
```

------------------------------------------------------------------------------
Maximize test runner window to fit the viewport.
------------------------------------------------------------------------------

### get\_should\_maximize

```gdscript
func get_should_maximize()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### maximize

```gdscript
func maximize()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### disable\_strict\_datatype\_checks

```gdscript
func disable_strict_datatype_checks(should)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### is\_strict\_datatype\_checks\_disabled

```gdscript
func is_strict_datatype_checks_disabled()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### end\_yielded\_test

```gdscript
func end_yielded_test()
```

------------------------------------------------------------------------------
Pauses the test and waits for you to press a confirmation button.  Useful when
you want to watch a test play out onscreen or inspect results.
------------------------------------------------------------------------------

### clear\_text

```gdscript
func clear_text()
```

------------------------------------------------------------------------------
Clears the text of the text box.  This resets all counters.
------------------------------------------------------------------------------

### get\_test\_count

```gdscript
func get_test_count()
```

------------------------------------------------------------------------------
Get the number of tests that were ran
------------------------------------------------------------------------------

### get\_assert\_count

```gdscript
func get_assert_count()
```

------------------------------------------------------------------------------
Get the number of assertions that were made
------------------------------------------------------------------------------

### get\_pass\_count

```gdscript
func get_pass_count()
```

------------------------------------------------------------------------------
Get the number of assertions that passed
------------------------------------------------------------------------------

### get\_fail\_count

```gdscript
func get_fail_count()
```

------------------------------------------------------------------------------
Get the number of assertions that failed
------------------------------------------------------------------------------

### get\_pending\_count

```gdscript
func get_pending_count()
```

------------------------------------------------------------------------------
Get the number of tests flagged as pending
------------------------------------------------------------------------------

### get\_result\_text

```gdscript
func get_result_text()
```

------------------------------------------------------------------------------
Get the results of all tests ran as text.  This string is the same as is
displayed in the text box, and similar to what is printed to the console.
------------------------------------------------------------------------------

### set\_log\_level

```gdscript
func set_log_level(level)
```

------------------------------------------------------------------------------
Set the log level.  Use one of the various LOG_LEVEL_* constants.
------------------------------------------------------------------------------

### get\_log\_level

```gdscript
func get_log_level()
```

------------------------------------------------------------------------------
Get the current log level.
------------------------------------------------------------------------------

### pause\_before\_teardown

```gdscript
func pause_before_teardown()
```

------------------------------------------------------------------------------
Call this method to make the test pause before teardown so that you can inspect
anything that you have rendered to the screen.
------------------------------------------------------------------------------

### set\_ignore\_pause\_before\_teardown

```gdscript
func set_ignore_pause_before_teardown(should_ignore)
```

------------------------------------------------------------------------------
For batch processing purposes, you may want to ignore any calls to
pause_before_teardown that you forgot to remove.
------------------------------------------------------------------------------

### get\_ignore\_pause\_before\_teardown

```gdscript
func get_ignore_pause_before_teardown()
```

### set\_yield\_between\_tests

```gdscript
func set_yield_between_tests(should)
```

------------------------------------------------------------------------------
Set to true so that painting of the screen will occur between tests.  Allows you
to see the output as tests occur.  Especially useful with long running tests that
make it appear as though it has humg.

NOTE:  not compatible with 1.0 so this is disabled by default.  This will
change in future releases.
------------------------------------------------------------------------------

### get\_yield\_between\_tests

```gdscript
func get_yield_between_tests()
```

### simulate

```gdscript
func simulate(obj, times, delta)
```

------------------------------------------------------------------------------
Call _process or _fixed_process, if they exist, on obj and all it's children
and their children and so and so forth.  Delta will be passed through to all
the _process or _fixed_process methods.
------------------------------------------------------------------------------

### set\_yield\_time

```gdscript
func set_yield_time(time, text = "")
```

------------------------------------------------------------------------------
Starts an internal timer with a timeout of the passed in time.  A 'timeout'
signal will be sent when the timer ends.  Returns itself so that it can be
used in a call to yield...cutting down on lines of code.

Example, yield to the Gut object for 10 seconds:
 yield(gut.set_yield_time(10), 'timeout')
------------------------------------------------------------------------------

### set\_yield\_frames

```gdscript
func set_yield_frames(frames, text = "")
```

------------------------------------------------------------------------------
Sets a counter that is decremented each time _process is called.  When the
counter reaches 0 the 'timeout' signal is emitted.

This actually results in waiting N+1 frames since that appears to be what is
required for _process in test.gd scripts to count N frames.
------------------------------------------------------------------------------

### set\_yield\_signal\_or\_time

```gdscript
func set_yield_signal_or_time(obj, signal_name, max_wait, text = "")
```

------------------------------------------------------------------------------
This method handles yielding to a signal from an object or a maximum
number of seconds, whichever comes first.
------------------------------------------------------------------------------

### get\_unit\_test\_name

```gdscript
func get_unit_test_name()
```

------------------------------------------------------------------------------
get the specific unit test that should be run
------------------------------------------------------------------------------

### set\_unit\_test\_name

```gdscript
func set_unit_test_name(test_name)
```

------------------------------------------------------------------------------
set the specific unit test that should be run.
------------------------------------------------------------------------------

### file\_touch

```gdscript
func file_touch(path)
```

------------------------------------------------------------------------------
Creates an empty file at the specified path
------------------------------------------------------------------------------

### file\_delete

```gdscript
func file_delete(path)
```

------------------------------------------------------------------------------
deletes the file at the specified path
------------------------------------------------------------------------------

### is\_file\_empty

```gdscript
func is_file_empty(path)
```

------------------------------------------------------------------------------
Checks to see if the passed in file has any data in it.
------------------------------------------------------------------------------

### get\_file\_as\_text

```gdscript
func get_file_as_text(path)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### directory\_delete\_files

```gdscript
func directory_delete_files(path)
```

------------------------------------------------------------------------------
deletes all files in a given directory
------------------------------------------------------------------------------

### get\_current\_script\_object

```gdscript
func get_current_script_object()
```

------------------------------------------------------------------------------
Returns the instantiated script object that is currently being run.
------------------------------------------------------------------------------

### get\_current\_test\_object

```gdscript
func get_current_test_object()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_stubber

```gdscript
func get_stubber()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_doubler

```gdscript
func get_doubler()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_spy

```gdscript
func get_spy()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_temp\_directory

```gdscript
func get_temp_directory()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### set\_temp\_directory

```gdscript
func set_temp_directory(temp_directory)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_inner\_class\_name

```gdscript
func get_inner_class_name()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### set\_inner\_class\_name

```gdscript
func set_inner_class_name(inner_class_name)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_summary

```gdscript
func get_summary()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_double\_strategy

```gdscript
func get_double_strategy()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### set\_double\_strategy

```gdscript
func set_double_strategy(double_strategy)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_include\_subdirectories

```gdscript
func get_include_subdirectories()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_logger

```gdscript
func get_logger()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### set\_logger

```gdscript
func set_logger(logger)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### set\_include\_subdirectories

```gdscript
func set_include_subdirectories(include_subdirectories)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_test\_collector

```gdscript
func get_test_collector()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_export\_path

```gdscript
func get_export_path()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### set\_export\_path

```gdscript
func set_export_path(export_path)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_version

```gdscript
func get_version()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_pre\_run\_script

```gdscript
func get_pre_run_script()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### set\_pre\_run\_script

```gdscript
func set_pre_run_script(pre_run_script)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_post\_run\_script

```gdscript
func get_post_run_script()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### set\_post\_run\_script

```gdscript
func set_post_run_script(post_run_script)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_pre\_run\_script\_instance

```gdscript
func get_pre_run_script_instance()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_post\_run\_script\_instance

```gdscript
func get_post_run_script_instance()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_color\_output

```gdscript
func get_color_output()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### set\_color\_output

```gdscript
func set_color_output(color_output)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_parameter\_handler

```gdscript
func get_parameter_handler()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### set\_parameter\_handler

```gdscript
func set_parameter_handler(parameter_handler)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_gui

```gdscript
func get_gui()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_orphan\_counter

```gdscript
func get_orphan_counter()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### show\_orphans

```gdscript
func show_orphans(should)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_autofree

```gdscript
func get_autofree()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_junit\_xml\_file

```gdscript
func get_junit_xml_file()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### set\_junit\_xml\_file

```gdscript
func set_junit_xml_file(junit_xml_file)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### get\_junit\_xml\_timestamp

```gdscript
func get_junit_xml_timestamp()
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------

### set\_junit\_xml\_timestamp

```gdscript
func set_junit_xml_timestamp(junit_xml_timestamp)
```

------------------------------------------------------------------------------
------------------------------------------------------------------------------