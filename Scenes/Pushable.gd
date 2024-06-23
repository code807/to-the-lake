class_name Pushable extends RigidBody2D

const STRENGTH = 75

func pushed(pusher: Node2D):
	if linear_velocity.length() < 10:
		$AudioStreamPlayer.play()
		if $DialogueTrigger != null:
			$DialogueTrigger.process_mode = Node.PROCESS_MODE_INHERIT
		print("pushed!")
		var direction = (global_position - pusher.global_position).normalized()
		apply_central_impulse(direction * STRENGTH)
