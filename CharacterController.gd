class_name Player extends CharacterBody2D

const SPEED = 200.0
const MOVEMENT_SMOOTHING = 50

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		direction *= SPEED
		velocity = velocity.move_toward(direction, MOVEMENT_SMOOTHING)
	else:
		velocity =  velocity.move_toward(Vector2(0,0), MOVEMENT_SMOOTHING)

	move_and_slide()
