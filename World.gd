extends Node2D

var obstac_number: int = 1

onready var mirr = preload("res://Mirror/Mirror.tscn")
onready var target: Node2D = $NodeTarget
onready var mirror: StaticBody2D = $Mirror
onready var mirror2: StaticBody2D = $Mirror2
#onready var world = load("res://World.tscn")

func _ready() ->void:
	PlayerData.connect("score_updated", self, "_update_mirror")
	PlayerData.connect("score_updated", self, "_update_mirror2")
	PlayerData.connect("score_updated", self, "_update_target")
	obstac_number = int(sqrt(PlayerData.score))
	_update_mirror()
	_update_target()
	_update_mirror2()
	while obstac_number>=2:
		var mirror_instance = mirr.instance()
		mirror_instance.position = Vector2(mirror_random_generator_number_x(),mirror_random_generator_number_y())
		mirror_instance.rotation_degrees=randi()%180
		add_child(mirror_instance)
		mirror_instance.add_to_group("Mirrors")
		obstac_number-=1

func _update_mirror():
	randomize()
	mirror.position = Vector2(mirror_random_generator_number_x(), mirror_random_generator_number_y())
	if mirror.position.y >= 640:
		mirror.rotation_degrees = 90

func _update_mirror2():
	randomize()
	mirror2.position = Vector2(1,2)

#func mirror_creation():
#	var mirror_instance = mirror2.instance()
#	mirror_instance.position = Vector2(randi()%10*10 + 500,obstacle_random_generator_number())
#	get_parent().call_deferred("add_child",mirror_instance)


func _update_target():
	randomize()
	target.position = Vector2(randi()%180 + 770, randi()%500 + 50)

func mirror_random_generator_number_x():
	randomize()
	var random =randi()%530 + 180
	return random

func mirror_random_generator_number_y():
	randomize()
	var random = randi()%400 + 60
	return random 
