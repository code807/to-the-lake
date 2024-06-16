extends RichTextLabel
var moreorless = true

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_finished()
	pass # Replace with function body.
	
		# Do something
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if randf() > 0.8:
		#moreorless = !moreorless
	#text = text+"a" if moreorless else text.erase(0, 1)
	#pass


func _on_finished():
	size.y = get_content_height()
	
	set_position(Vector2(6, get_parent_area_size().y-size.y-12))
	# reset_size()
	# update_minimum_size()
	# size = get_minimum_size()
	print("something somewhere was set")
	pass # Replace with function body.
