<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# gut\_config.gd

## Enumerations

### DOUBLE\_STRATEGY

```gdscript
const DOUBLE_STRATEGY: Dictionary = {"FULL":0,"PARTIAL":1}
```

Do not want a ref to _utils here due to use by editor plugin.
_utils needs to be split so that constants and what not do not
have to rely on the weird singleton thing I made.

## Property Descriptions

### Gut

```gdscript
class gut_config.gd
```

### valid\_fonts

```gdscript
var valid_fonts
```

### default\_options

```gdscript
var default_options
```

### options

```gdscript
var options
```

## Method Descriptions

### write\_options

```gdscript
func write_options(path)
```

### config\_gut

```gdscript
func config_gut(gut)
```

### load\_options

```gdscript
func load_options(path)
```

### load\_options\_no\_defaults

```gdscript
func load_options_no_defaults(path)
```

### apply\_options

```gdscript
func apply_options(gut)
```

