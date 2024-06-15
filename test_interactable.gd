extends Interactable

var normal_color = Color(0.25, 0.25, 0.25)
var highlight_color = Color(1, 1, 1)

func _on_highlight(value: bool):
	if value:
		$Sprite2D.modulate = highlight_color
	else:
		$Sprite2D.modulate = normal_color
