extends ColorRect

@onready var animation = $AnimationPlayer

func fade_to_black():
	print("fading to black")
	animation.current_animation = "new_animation"
	animation.play()

func fade_back():
	animation.current_animation = "new_animation"
	animation.play_backwards()
