class_name ThreadPool
extends RefCounted

# === Threads and Mutex ===
var threads:Array     = []
var mutex:Mutex       = Mutex.new()

var threads_preparing = [] # thread started
var threads_running   = [] #
# === object properties ===

# initialize the object
func _init(object:Object,method:String,args:Array,cpu_threads:int = OS.get_processor_count()):
    self.object       = object
    self.method       = method
    self.args         = args
    self.cpu_threads  = cpu_threads

    # create the threads based checked the arguments
    for x in args:
        threads.append(Thread.new())
    
    # start the threads
    start_threads(object, method, args, cpu_threads)
    
    
# start the threads
func start_threads(object, method, args, cpu_threads) -> void:
    # create threads and assign them to the thread starts
    for _process in range(cpu_threads):
        threads_preparing.append(threads.front())
        threads.pop_front()
    
    # run the threads
    run_threads(object, method, args, cpu_threads)

# run the threads
func run_threads(object:Object, method:String, args:Array, cpu_threads:int):
    # start the processes 
    for process in threads_preparing:
        process.start(
            object.new(),
            method,
            args.front()
        )
        
        # remove the argument and tally
        threads_running.append(threads_preparing.front())
        threads_running.pop_front()
        args.pop_front()

    # if the threads is not empty it loop through the start threads 
    if !(threads.size() == 0):
        start_threads(
            object,
            method,
            args,
            cpu_threads
        )
    else:
        join_threads()

# join the threads
func join_threads()->void:
    for x in threads_running:
        x.wait_to_finish()
    