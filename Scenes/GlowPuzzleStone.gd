@tool
class_name MemoryStone
extends Interactable

@export var color: ColorType: set = _setColor
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation = $AnimationPlayer
var GlowColor: Color
var glowing = false: set = _setGlow

signal tapped(Node2D)

enum ColorType {
	GREEN,
	RED,
	BLUE
}

func _setGlow(value):
	if value != glowing:
		if animation:
			if value:
				animation.play()
			else:
				animation.play_backwards()
	glowing = value

func _firesignal(node: Node2D):
	print("stone tapped")
	emit_signal("tapped", self)

func _setColor(value):
	if sprite:
		match value:
			ColorType.GREEN:
				sprite.frame = 1
				GlowColor = Color.GREEN*0.5+Color.WHITE
				animation.current_animation = "green"
				animation.stop()
			ColorType.RED:
				sprite.frame = 2
				GlowColor = Color.RED*0.5+Color.WHITE
				animation.current_animation = "red"
				animation.stop()
			ColorType.BLUE:
				sprite.frame = 0
				GlowColor = Color.BLUE*0.5+Color.WHITE
				animation.current_animation = "blue"
				animation.stop()
	color = value

# Called when the node enters the scene tree for the first time.
func _ready():
	color = color
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
