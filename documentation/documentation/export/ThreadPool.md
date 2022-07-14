<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# ThreadPool

**Extends:** [Reference](../Reference)

## Description

## Property Descriptions

### threads

```gdscript
var threads: Array
```

=== Threads and Mutex ===

### mutex

```gdscript
var mutex: Mutex
```

=== Threads and Mutex ===

### threads\_preparing

```gdscript
var threads_preparing
```

thread started

### threads\_running

```gdscript
var threads_running
```

## Method Descriptions

### \_init

```gdscript
func _init(object: Object, method: String, args: Array, cpu_threads: int) -> void
```

=== object properties ===
initialize the object

### start\_threads

```gdscript
func start_threads(object, method, args, cpu_threads) -> void
```

start the threads

### run\_threads

```gdscript
func run_threads(object: Object, method: String, args: Array, cpu_threads: int)
```

run the threads

### join\_threads

```gdscript
func join_threads() -> void
```

join the threads