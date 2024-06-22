class_name WarpPoint extends DialogueTrigger

@export var destination: String
@export var warpindex: int
@export var dialogue_time: int
@export var auto: bool

func _ready():
	if get_node_or_null("Polygon2D2/label") != null:
		$Polygon2D2/label.text = destination
