class_name Player extends CharacterBody2D

signal dialogue_trigger(Array)
signal warp_trigger(String, int)
signal one_off(int)

#const SPEED = 75.0
const SPEED = 55.0
const MOVEMENT_SMOOTHING = 10
const STOP_SMOOTHING = 50
@onready var sprite = $AnimatedSprite2D
var interactables: Array[Interactable] = []
var closest = null

var animindex = -1
var animlist = ["walk_up", "walk_left", "walk_right", "walk_down"]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if closest != null:
			closest.interacted.emit(self)
	if interactables.size() > 0:
		var closest_distance: float = INF
		for item in interactables:
			var item_distance = global_position.distance_to(item.global_position)
			if item_distance < closest_distance:
				if closest != item:
					if closest != null:
						closest.highlight = false
					closest = item
					closest_distance = item_distance
					closest.highlight = true


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


func _on_area_2d_area_entered(area):
	if area is Interactable:
		interactables.append(area)
	elif area is WarpPoint:
		emit_signal("warp_trigger", area.dialogue_time, area.destination, area.warpindex)
		dialogue_trigger.emit(area.dialogue)
	elif area is DialogueTrigger:
		dialogue_trigger.emit(area.dialogue)
		if area.oneoff == true:
			# emit_signal("one_off", area.id)
			area.flag.state = true
			# area.queue_free()


func _on_area_2d_area_exited(area):
	if area is Interactable:
		interactables.erase(area)
		area.highlight = false
		if interactables.size() == 0:
			closest = null
