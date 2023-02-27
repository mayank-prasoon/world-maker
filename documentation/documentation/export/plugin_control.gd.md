<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# plugin\_control.gd

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
This is the control that is added via the editor.  It exposes GUT settings
through the editor and delays the creation of the GUT instance until
Engine.get_main_loop() works as expected.
##############################################################################

## Method Descriptions

### get\_gut

```gdscript
func get_gut()
```

### export\_if\_tests\_found

```gdscript
func export_if_tests_found()
```

### import\_tests\_if\_none\_found

```gdscript
func import_tests_if_none_found()
```

## Signals

- signal tests_finished(): ------------------------------------------------------------------------------
Signals
------------------------------------------------------------------------------
Emitted when all the tests have finished running.
- signal gut_ready(): ------------------------------------------------------------------------------
Signals
------------------------------------------------------------------------------
Emitted when all the tests have finished running.
Emitted when GUT is ready to be interacted with, and before any tests are run.
