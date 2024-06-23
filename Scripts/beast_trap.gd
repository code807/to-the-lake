extends Area2D

@onready var sprite = $Sprite2D
@onready var static_body = $StaticBody2D
@onready var talkable = $Talkable

var closed := false:
	set = _set_closed


func _set_closed(is_closed: bool):
	if is_closed:
		$AudioStreamPlayer.play()
	sprite.texture.region.position.x = 16 if is_closed else 0
	static_body.process_mode = Node.PROCESS_MODE_DISABLED if is_closed \
			else Node.PROCESS_MODE_INHERIT


func _on_set_flag(id: int, flag_state: bool):
	closed = flag_state


func _on_body_entered(body):
	if body is Pushable:
		talkable.dialogue_trigger.emit(talkable.dialogue)
		var dialogue_trigger = get_node_or_null("DialogueTrigger")
		if dialogue_trigger != null:
			dialogue_trigger.process_mode = Node.PROCESS_MODE_DISABLED
		closed = true
		body.process_mode = Node.PROCESS_MODE_DISABLED
		$PersistentDatum.state = true
