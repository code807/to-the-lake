## Dynamic tileset resource which uses a gradient texture to create solid colored tiles.
## Useful for prototyping tilemaps without manually drawing a tileset.
@tool
class_name ColorTilesetTiles extends GradientTexture2D

## The tile size, in pixels. For all tile shapes, this size corresponds to the encompassing
## rectangle of the tile shape. This is thus the minimal cell size required in an atlas.
@export var tile_size: Vector2i = Vector2i(16, 16):
	get: return tile_size
	set(value):
		tile_size = value
		update()

## Solid colors associated to each individual tile. No limit to the amount.
## Colors are drawn from left to right in one row.
@export var tile_colors: Array[Color] = [
	Color.BLACK,
	Color.WHITE,
	Color.RED,
	Color.GREEN,
	Color.BLUE,
	Color.YELLOW,
	Color.CYAN,
	Color.MAGENTA
]:
	get: return tile_colors
	set(value):
		if value.is_empty():
			value = [Color.BLACK]
		tile_colors = value
		update()

@export_group("Editor", "editor_")
## Refresh GradientTexture2D properties based on ColorTileset properties.
## Only necessary if GradientTexture2D properties are changed manually.
@export var editor_update: bool:
	get: return false
	set(__):
		update()

func _init() -> void:
	update.call_deferred()

func update() -> void:
	var color_count = tile_colors.size()
	
	var offsets: PackedFloat32Array = PackedFloat32Array()
	for index in color_count:
		offsets.push_back(index / float(color_count))
	
	width = tile_size.x * color_count
	height = tile_size.y
	
	fill = FILL_LINEAR
	fill_from = Vector2.ZERO
	fill_to = Vector2.RIGHT
	
	gradient = Gradient.new()
	gradient.interpolation_mode = Gradient.GRADIENT_INTERPOLATE_CONSTANT
	gradient.colors = tile_colors
	gradient.offsets = offsets
