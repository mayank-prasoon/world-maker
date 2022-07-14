extends Node2D

# Obtain access to my plugin
onready var Log = $Logger

# Some example calls
func _ready():
#	Standard calls with no secondary parameter
	Log.debug("This is a debug statement")
	Log.info("Information is ready")
	Log.warn("Warning thrown") # Note: I could have also used Log.warning("Warning msg is same")
#	More advanced calls with a second parameter (Decides to exit/end the progam
#	This is calling error and setting it's auto_exit to false (it's default for errors)
	Log.error("Failed obtaining acorns from squirrel army", false)
#	This is calling critical (or crit) with it's default auto_exit setting (critical/crit will automatically exit)
	Log.critical("This will auto exit after called", true) # Change to false to continue the program
	printerr("This only goes to the console")
	
	# Logger also includes some assistant functions
	print("Current datetime stamp: ", Log.timestamp("{month}/{day}/{year} {12hour}:{min}:{sec} {ampm}")) # I.E. '01/01/2000 01:53:22 AM'
	print("Position of Example Logging node: ", Log.pos2str(self.position)) # This is so you can print positions
