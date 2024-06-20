class_name Main extends Control

var lname: String
var player: Player
var player_scene = preload("res://Scenes/Player.tscn")
@onready var dialogue_manager: DialogueManager = $HUD/DialogueManager
var spawn: Vector2
const levels := {
	"test_level": preload("res://Scenes/test_level.tscn"),
	"test_level_1": preload("res://Scenes/test_level_1.tscn"),
	"test_puzzle_1": preload("res://Scenes/test_puzzle_1.tscn"),
	"hub": preload("res://Scenes/hub_level.tscn")
}
var level:Level

var oneoffs = {} # flags, format: <levelname>-<triggerid>

# Called when the node enters the scene tree for the first time.
func _ready():
	load_level("hub")

func one_off_check(id: int):
	if lname in oneoffs:
		oneoffs[lname].append(id)
	else:
		oneoffs[lname] = [id]
	pass

func load_level(level_name: String, spawn_index: int = 0):
	for collectable in get_tree().get_nodes_in_group("oneoff"):
		collectable.remove_from_group("oneoff")
	if level_name in levels:
		lname = level_name
		if level != null:
			level.queue_free()
		level = levels[level_name].instantiate()
		add_child(level)
		var setid = 0
		for oneoff in get_tree().get_nodes_in_group("oneoff"):
			if oneoff is DialogueTrigger:
				oneoff.id = setid
				setid += 1
				if lname in oneoffs:
					if oneoff.id in oneoffs[lname]:
						oneoff.queue_free()
		for talkable in get_tree().get_nodes_in_group("talkable"):
			talkable.dialogue_trigger.connect(dialogue_manager._on_dialogue_trigger)
		if level.spawn_points.size() > spawn_index:
			spawn = level.spawn_points[spawn_index].global_position
		else:
			spawn = level.spawn
		_spawn_player()


func _spawn_player():
	if player != null:
		player.queue_free()
	player = player_scene.instantiate()
	add_child(player)
	player.global_position = spawn
	player.dialogue_trigger.connect(dialogue_manager._on_dialogue_trigger)
	player.warp_trigger.connect(load_level)
	player.one_off.connect(one_off_check)
