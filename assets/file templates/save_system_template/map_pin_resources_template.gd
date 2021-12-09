class_name MapPin
extends Resource

# === MAP PIN ===

export(String)     var pin_name:String                                          # name of the pin
export(int)        var pin_symbol_template:int                                  # symbol template used for the pin
export(Vector2)    var pin_location:Vector2                                     # location of the pin in the map
export(Resource)   var pin_article:Resource                                     # article attached to the pin
export(bool)       var map_link_state                                           # state of the link
export(Resource)   var linked_chunk                                             # chunk which is linked to the pin
