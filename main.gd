class_name Main extends Control

var player: Player
var player_scene = preload("res://Player.tscn")
@onready var dialogue_manager: DialogueManager = $HUD/DialogueManager
var spawn: Vector2
const levels := {
	"test_level": preload("res://test_level.tscn"),
	"test_level_1": preload("res://Scenes/test_level_1.tscn")
}
var level:Level


# Called when the node enters the scene tree for the first time.
func _ready():
	load_level("test_level_1")


func load_level(level_name: String, spawn_index: int = 0):
	if level_name in levels:
		if level != null:
			level.queue_free()
		level = levels[level_name].instantiate()
		add_child(level)
		print(level.spawn_points.size())
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
