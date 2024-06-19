class_name Pushable extends RigidBody2D

const STRENGTH = 50

func pushed(pusher: Node2D):
	if linear_velocity.length() < 1:
		print("pushed!")
		var direction = (global_position - pusher.global_position).normalized()
		print(str(direction))
		apply_central_impulse(direction * STRENGTH)
