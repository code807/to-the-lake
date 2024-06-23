extends Interactable

@onready var animation = $AnimationPlayer
@onready var audioplayer = $AudioStreamPlayer

var sequence: Array[int]
var currentseq: Array[int]
var demoindex = 0

var sounds = [
	preload("res://Assets/b1.wav"),
	preload("res://Assets/b2.wav"),
	preload("res://Assets/b3.wav"),
	preload("res://Assets/SNAKEBELL3.wav"),
	preload("res://Assets/SNAKE CANDLE BYE BYE.wav")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var i = 0
	for child in get_children():
		if child is MemoryStone:
			child.connect("tapped", _touchstone)
			sequence.insert(randi_range(0, sequence.size()), child.get_index())
	pass # Replace with function body.

func _touchstone(stone: MemoryStone):
	print("stone touched!")
	if currentseq.size() < sequence.size():
		if sequence[currentseq.size()] == stone.get_index():
			currentseq.append(stone.get_index())
			stone.glowing = true
			match stone.color:
				MemoryStone.ColorType.RED:
					audioplayer.stream = sounds[0]
					audioplayer.play()
				MemoryStone.ColorType.BLUE:
					audioplayer.stream = sounds[1]
					audioplayer.play()
				MemoryStone.ColorType.GREEN:
					audioplayer.stream = sounds[2]
					audioplayer.play()
		else:
			audioplayer.stream = sounds[3]
			audioplayer.play()
			for child in get_children():
				if child is MemoryStone:
					currentseq.clear()
					child.glowing = false

func startdemo(Node2D):
	if currentseq.size() < sequence.size():
		print("demo is theoretically starting")
		animation.play("DEFAULT")
		demoindex = -1
		_nextinsequence("")
	else:
		audioplayer.stream = sounds[4]
		audioplayer.play()
		$fireanimation.play("die")
		for child in get_children():
			if child is MemoryStone:
				currentseq.clear()
				child.glowing = false
	pass

func _nextinsequence(name):
	demoindex += 1
	if demoindex < sequence.size():
		match get_child(sequence[demoindex]).color:
			MemoryStone.ColorType.RED:
				print("playing red")
				animation.play("red")
				audioplayer.stream = sounds[0]
				audioplayer.play()
			MemoryStone.ColorType.BLUE:
				print("playing blue")
				animation.play("blue")
				audioplayer.stream = sounds[1]
				audioplayer.play()
			MemoryStone.ColorType.GREEN:
				print("playing green")
				animation.play("green")
				audioplayer.stream = sounds[2]
				audioplayer.play()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
