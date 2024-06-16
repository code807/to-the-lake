class_name DialogueBox extends Control

@onready var label = $RichTextLabel
@onready var timer = $Timer
@onready var lettertimer = $LetterTimer
var lettertime = 0
var string: String = ""

func _ready():
	label.visible = false


func play_dialogue(dialogue: String, speech_time: float, pause_time: float):
	print("Dialog box is playing " + dialogue + " for time " + str(speech_time))
	label.text = ""
	string = dialogue
	label.visible = true
	timer.start(speech_time+pause_time)
	lettertime = speech_time/string.length()
	_newletter()

func _newletter():
	if string.length() > 0:
		label.text = label.text+string[0]
		string = string.erase(0)
		lettertimer.start(lettertime)

func _on_timer_timeout():
	print("Dialogue stopped!")
	label.visible = false
