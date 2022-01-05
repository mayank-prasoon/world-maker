extends Control

func _ready():
	display_entire_map(load("res://save_files/maps/house_save_data.tres"))

func display_entire_map(map:MapData) -> void:
	for x in map.layers:
		for y in x:
			var chunk:MapFragment            = load(y)
			var new_texture_rect:TextureRect = TextureRect.new()

			new_texture_rect.texture         = chunk
			new_texture_rect.rect_position   = chunk.chunk_position

			add_child(new_texture_rect)
