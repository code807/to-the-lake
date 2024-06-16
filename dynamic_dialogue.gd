class_name DialogueBox extends Control

@onready var label = $RichTextLabel
@onready var timer = $Timer

var dialogue_queue: Array[Dictionary] = []

func _ready():
	label.visible = false


func play_dialogue(dialogue: String):
	print("playing dialogue" + dialogue)
	label.text = dialogue
	label.visible = true
	timer.start(5)


func _on_timer_timeout():
	label.visible = false


func _on_dialogue_trigger(dialogues: Array[Dictionary]):
	print("playing dialogues" + str(dialogues))
	#if dialogues.size() > 0:
	play_dialogue(dialogues[0][StoryTellers.names.CHRIS])
		#dialogues.erase(0)
	#if dialogues.size() > 0:
		#pass

