class_name Main extends Control

var lname: String
var player: Player
var player_scene = preload("res://Scenes/Player.tscn")
@onready var dialogue_manager: DialogueManager = $HUD/DialogueManager
@onready var color_rect = $HUD/ColorRect
var spawn: Vector2
@onready var fade_to_black_timer = $FadeToBlackTimer
var next_level: String
var next_level_spawn_index: int

@export var introdialog: Array[DialogResource]

const levels := {
	"test_level": preload("res://Scenes/test_level.tscn"),
	"test_level_1": preload("res://Scenes/test_level_1.tscn"),
	"test_puzzle_1": preload("res://Scenes/test_puzzle_1.tscn"),
	"test_puzzle_2": preload("res://Scenes/test_puzzle_2.tscn"),
	"final_level": preload("res://Scenes/final_level.tscn"),
	"intro_level": preload("res://Scenes/intro_level.tscn"),
	"end": preload("res://Scenes/the_end_of_the_game.tscn"),
	"hub": preload("res://Scenes/hub_level.tscn")
}
var level:Level

var flags = {} # flags, format: <levelname>-<triggerid>

func _start_game():
	$"HUD/Main Menu".process_mode = Node.PROCESS_MODE_DISABLED
	next_level = "intro_level"
	next_level_spawn_index = 0
	color_rect.fade_to_black()
	#  fade_to_black_timer.start(0)
	fade_to_black_timer.start(40)
	dialogue_manager._on_dialogue_trigger(introdialog)
	get_tree().paused = true
	

# Called when the node enters the scene tree for the first time.
# func _ready():
# 	load_level("hub")

func _gameover():
	$"HUD/Main Menu".visible = true
	$"HUD/Main Menu".process_mode = Node.PROCESS_MODE_ALWAYS
	flags = {}
	pass

func fade_to_black(time: float, level_name: String, spawn_index: int = 0):
	if time != 0:
		next_level = level_name
		next_level_spawn_index = spawn_index
		color_rect.fade_to_black()
		fade_to_black_timer.start(time)
		get_tree().paused = true
	else:
		load_level(level_name, spawn_index)

func fade_back():
	if $"HUD/Main Menu".visible:
		$"HUD/Main Menu".visible = false
	load_level(next_level, next_level_spawn_index)
	get_tree().paused = false
	color_rect.fade_back()

func load_level(level_name: String, spawn_index: int = 0):
	for collectable in get_tree().get_nodes_in_group("PersistentFlag"):
		collectable.remove_from_group("PersistentFlag")
	if level_name in levels:
		lname = level_name
		if level != null:
			level.queue_free()
		level = levels[level_name].instantiate()
		add_child(level)
		var setid = 0 # PersistantFlag
		for flag in get_tree().get_nodes_in_group("PersistentFlag"):
			if flag is PersistentDatum:
				flag.id = setid
				setid += 1
				if lname in flags:
					if flag.id in flags[lname]:
						flag.state = true
				flag.setflag.connect(_set_flag)

		for talkable in get_tree().get_nodes_in_group("talkable"):
			talkable.dialogue_trigger.connect(dialogue_manager._on_dialogue_trigger)
		if level.spawn_points.size() > spawn_index:
			spawn = level.spawn_points[spawn_index].global_position
		else:
			spawn = level.spawn
		_spawn_player()


func _set_flag(id: int, value: bool):
	print(flags)
	if not value:
		if lname in flags:
			if id in flags[lname]:
				flags[lname].erase(id)
	else:
		if lname in flags:
			if not (id in flags[lname]):
				flags[lname].append(id)
		else:
			flags[lname] = [id]


func _spawn_player():
	if player != null:
		player.queue_free()
	player = player_scene.instantiate()
	add_child(player)
	player.global_position = spawn
	#player.set_deferred("global_position", spawn)
	player.dialogue_trigger.connect(dialogue_manager._on_dialogue_trigger)
	player.warp_trigger.connect(fade_to_black)
	player.gameover.connect(_gameover)
