extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_volume(value):
	AudioServer.set_bus_volume_db(0, -40+40*$Control/HSlider.value)

func start_button_interaction():
	print("event")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
