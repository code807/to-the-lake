extends Area2D

@onready var sprite = $Sprite2D
@onready var static_body = $StaticBody2D

var closed := false:
	set = _set_closed

func _set_closed(value):
		if value:
			print("Sprite changed!")
			sprite.texture.region.position.x = 16
			static_body.process_mode = Node.PROCESS_MODE_DISABLED


func _on_body_entered(body):
	print("body entered!")
	if body is Pushable:
		print("The body is pushable!")
		closed = true
