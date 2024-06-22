@tool
extends AnimatedSprite2D

var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	animation = "1"
	add_child(timer)
	timer.connect("timeout", timerstuff)
	timer.start(randf_range(1, 3))
	for m in range(PI):
		print(m)
	pass # Replace with function body.

func timerstuff():
	if randf() > 0.5:
		if randf() > 0.5:
			play("1")
		else:
			play("2")
	timer.start(randf_range(4, 8))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
