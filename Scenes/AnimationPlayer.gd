extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func glow(state):
	print("we seekin to "+str(state))
	if state:
		play("glow")
	else:
		play_backwards("glow")
	# seek(0.4 if state else 0)
