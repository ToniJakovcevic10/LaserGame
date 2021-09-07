extends Node2D

onready var target: Node2D = $NodeTarget
onready var mirror: StaticBody2D = $Mirror
#onready var world = load("res://World.tscn")

func _ready() ->void:
	PlayerData.connect("score_updated", self, "_update_mirror")
	PlayerData.connect("score_updated", self, "_update_target")
	_update_mirror()
	_update_target()


func _update_mirror():
#	self.queue_free()
#	var world_instance = world.instance()
#	get_parent().call_deferred("add_child",world_instance)
	randomize()
	mirror.position = Vector2(randi()%450, randi()%500 + 50)
	mirror.rotation_degrees = randi()%360

func _update_target():
	randomize()
	target.position = Vector2(randi()%150 + 800, randi()%500 + 50)
