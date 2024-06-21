class_name DialogueBox extends Control

@export var storyteller: StoryTellers.names

@onready var label = $RichTextLabel
@onready var timer = $Timer
@onready var lettertimer = $LetterTimer

var lettertime = 0
var string: String = ""

func _ready():
	label.visible = false
	_on_finished()


func play_dialogue(dialogue: String, speech_time: float, pause_time: float):
	print("Dialog box is playing " + dialogue + " for time " + str(speech_time))
	match storyteller:
		StoryTellers.names.CHARLIE:
			label.text = "[color=#2482be]Jera[/color]\n"
		StoryTellers.names.TAYLOR:
			label.text = "[right][color=#9f24be]Dove[/color]\n[right]"
		StoryTellers.names.JEFF:
			label.text = "[color=#e69127]Charlie[/color]\n"
		StoryTellers.names.CHRIS:
			label.text = "[right][color=#fd8d00]Jak[/color]\n[right]"
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


func _on_finished():
	label.size.y = label.get_content_height()
	match(storyteller):
		StoryTellers.names.CHARLIE:
			label.set_position(Vector2(5,2))
		StoryTellers.names.TAYLOR:
			label.set_position(Vector2(size.x-label.size.x-5,2))
		StoryTellers.names.JEFF:
			label.set_position(Vector2(size.x-label.size.x-5, size.y-label.size.y-5))
		StoryTellers.names.CHRIS:
			label.set_position(Vector2(5, size.y-label.size.y-5))
	
