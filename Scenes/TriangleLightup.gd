extends Polygon2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func onoff(state: bool):
	color = Color.WHITE if state else Color.BLACK

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
