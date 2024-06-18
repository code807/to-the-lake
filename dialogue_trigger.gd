class_name DialogueTrigger extends Area2D

var id = -1
var oneoff = true

@export var dialogue: Array[DialogResource]

func _ready():
	add_to_group("oneoff")
