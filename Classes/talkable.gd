class_name Talkable extends Node2D

signal dialogue_trigger(Array)

@export var dialogue: Array[DialogResource]

func _ready():
	add_to_group("talkable")
