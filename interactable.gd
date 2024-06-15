class_name Interactable extends Area2D

var highlight := false : set = set_highlight

func set_highlight(new_highlight: bool):
	highlight = new_highlight
	_on_highlight(new_highlight)


func _on_highlight(value: bool):
	pass
