extends Area2D

@onready var sprite = $Sprite2D
@onready var static_body = $StaticBody2D
@onready var talkable = $Talkable

var closed := false:
	set = _set_closed

func _set_closed(value):
		if value:
			sprite.texture.region.position.x = 16
			static_body.process_mode = Node.PROCESS_MODE_DISABLED


func _on_body_entered(body):
	if body is Pushable:
		talkable.dialogue_trigger.emit(talkable.dialogue)
		closed = true
