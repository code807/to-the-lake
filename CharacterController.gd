class_name Player extends CharacterBody2D

const SPEED = 75.0
const MOVEMENT_SMOOTHING = 10
const STOP_SMOOTHING = 50
@onready var sprite = $AnimatedSprite2D

var animindex = 1
var animlist = ["walk_up", "walk_left", "walk_right", "walk_down"]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		if not sprite.is_playing():
			sprite.play()
		var strongaxis = direction.max_axis_index()
		var mindex = strongaxis+2 if sign(direction[strongaxis]) > 0 else strongaxis
		if mindex != animindex:
			animindex = mindex
			sprite.animation = animlist[animindex]
			sprite.play()
		direction *= SPEED
		velocity = velocity.move_toward(direction, MOVEMENT_SMOOTHING)
	else:
		velocity =  velocity.move_toward(Vector2(0,0), STOP_SMOOTHING)
	move_and_slide()

func _checkanim():
	if sprite.frame%3 == 0 and velocity.length() <= 5:
		sprite.frame = 0
		sprite.stop()
