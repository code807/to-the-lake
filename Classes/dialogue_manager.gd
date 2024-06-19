class_name DialogueManager extends Control

@onready var timer = $Timer

@onready var dialogue_box_dict = {
	StoryTellers.names.CHARLIE: $Charlie,
	StoryTellers.names.TAYLOR: $Taylor,
	StoryTellers.names.JEFF: $Jeff,
	StoryTellers.names.CHRIS: $Chris
}
var dialogue_queue = []

func _on_dialogue_trigger(dialogues: Array[DialogResource]):
	print("playing dialogues" + str(dialogues))
	for dialogue in dialogues:
		dialogue_queue.append(dialogue)
	if timer.is_stopped():
		play_next_dialogue()


func play_next_dialogue():
	if(dialogue_queue.size() > 0):
		var dialogue = dialogue_queue.pop_front()
		play_dialogue(dialogue)
		timer.start(dialogue.wait_time)


func play_dialogue(dialogue: DialogResource):
	print("playing dialogue" + dialogue.dialogue)
	var dialogue_box: DialogueBox = dialogue_box_dict[dialogue.story_teller]
	dialogue_box.play_dialogue(dialogue.dialogue, dialogue.speech_time, dialogue.pause_time)
