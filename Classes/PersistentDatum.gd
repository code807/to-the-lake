class_name PersistentDatum extends Node

signal setflag(int, bool)

var id = -1
var state = false: set = _set_state

func _ready():
	add_to_group("PersistentFlag")

func _set_state(value):
	setflag.emit(id, value)
	state = value
