class_name DialogueBox extends Control

@onready var label = $RichTextLabel
@onready var timer = $Timer

func _ready():
	label.visible = false


func play_dialogue(dialogue: String, speech_time: float):
	print("Dialog box is playing " + dialogue + " for time " + str(speech_time))
	label.text = dialogue
	label.visible = true
	timer.start(speech_time)


func _on_timer_timeout():
	print("Dialogue stopped!")
	label.visible = false
