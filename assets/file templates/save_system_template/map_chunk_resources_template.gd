class_name MapChunkData
extends Resource

# === MAP CHUNK ====
# contains imformation of a chunk of a map

export(String)              var chunk_name:String                               # name of the chunk
export(String)              var chunk_id:String                                 # a unique id of the map chunk
export(Texture)             var chunk_texture:Texture                           # texture path of the chunk
export(Vector2)             var chunk_offset:Vector2                            # offeset of the chunk from the center ((0,0,0) is the center)
export(Array, Resource)     var chunk_pins:Array                                # pins present on that specific chunk
