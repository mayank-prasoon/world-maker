<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# orphan\_counter.gd

## Method Descriptions

### orphan\_count

```gdscript
func orphan_count()
```

### add\_counter

```gdscript
func add_counter(name)
```

### get\_counter

```gdscript
func get_counter(name)
```

Returns the number of orphans created since add_counter was last called for
the name.  Returns -1 to avoid blowing up with an invalid name but still
be somewhat visible that we've done something wrong.

### print\_orphans

```gdscript
func print_orphans(name, lgr)
```

