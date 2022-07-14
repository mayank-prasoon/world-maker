<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# strutils.gd

## Property Descriptions

### types

```gdscript
var types
```

Hash containing all the built in types in Godot.  This provides an English
name for the types that corosponds with the type constants defined in the
engine.

### NativeScriptClass

```gdscript
var NativeScriptClass
```

Hash containing all the built in types in Godot.  This provides an English
name for the types that corosponds with the type constants defined in the
engine.

## Method Descriptions

### type2str

```gdscript
func type2str(thing)
```

------------------------------------------------------------------------------
Better object/thing to string conversion.  Includes extra details about
whatever is passed in when it can/should.
------------------------------------------------------------------------------

### truncate\_string

```gdscript
func truncate_string(src, max_size)
```

------------------------------------------------------------------------------
Returns the string truncated with an '...' in it.  Shows the start and last
10 chars.  If the string is  smaller than max_size the entire string is
returned.  If max_size is -1 then truncation is skipped.
------------------------------------------------------------------------------

### indent\_text

```gdscript
func indent_text(text, times, pad)
```

