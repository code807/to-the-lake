class_name DialogueTrigger extends Area2D
var flag = PersistentDatum.new()

var id = -1
@export var oneoff = true

@export var dialogue: Array[DialogResource]

func _ready():
	add_child(flag)
	flag.setflag.connect(_updateflag)

func _updateflag(id: int, state: bool):
	if state and oneoff:
		queue_free()
