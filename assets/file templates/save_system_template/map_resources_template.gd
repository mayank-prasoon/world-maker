class_name MapData
extends Resource

# === DATA OF THE MAP ====

export(String)                      var map_name:String               # name of the map
export(TileSet)                     var image:TileSet                 # layer used in the map
export(Vector2)                     var chunk_size:Vector2            # chunk size
export(int)                         var chunk_number:int              # chunk number
export(Array, Resource)             var map_pins:Array                # map pins
export(Array, String)               var tags:Array                    # tags
