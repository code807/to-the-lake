class_name Interactable extends Area2D

var highlight := false : set = set_highlight
signal _highlight(bool)
signal interacted(Node2D)

func set_highlight(new_highlight: bool):
	highlight = new_highlight
	emit_signal("_highlight", new_highlight)
	_on_highlight(new_highlight)


func _on_highlight(value: bool):
	pass


func interact(interacter: Node2D):
	interacted.emit(interacter)
