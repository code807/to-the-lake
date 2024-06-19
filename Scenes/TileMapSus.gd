@tool
extends TileMap


# Called when the node enters the scene tree for the first time.
func aaa():
	var tiles: TileSetAtlasSource = tile_set.get_source(tile_set.get_source_id(3))
	
	for y in range(49):
		tiles.set_tile_animation_columns(Vector2i(0, y), 11)
		tiles.set_tile_animation_frames_count (Vector2i(0, y), 11)
		tiles.set_tile_animation_speed(Vector2i(0, y), 5)
	print("I tried")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
