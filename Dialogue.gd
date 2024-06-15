class_name Dialogue extends CanvasLayer

@onready var label = $TextureRect/MarginContainer/Label
@onready var timer = $Timer

func play_dialogue(dialogue: String):
	label.text = dialogue
	$TextureRect.visible = true
	timer.start(5)


func _on_timer_timeout():
	$TextureRect.visible = false

func _on_dialogue_trigger(dialogue: String):
	play_dialogue(dialogue)
