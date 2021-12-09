class_name MapChunkData
extends Resource

# === MAP CHUNK ====
# contains imformation of a chunk of a map

export(String)              var chunk_name:String                               # name of the chunk
export(String, FILE)        var chunk_texture:String                            # texture path of the chunk
export(Vector2)             var chunk_Offset:Vector2                            # offeset of the chunk from the center ((0,0,0) is the center)
export(Array, Resource)     var chink_pins:Array                                # pins present on that specific chunk
