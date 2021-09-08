extends Node2D

var obstac_number: int = 1

onready var target: Node2D = $NodeTarget
onready var mirror: StaticBody2D = $Mirror
onready var mirror2: StaticBody2D = $Mirror2
#onready var world = load("res://World.tscn")

func _ready() ->void:
	PlayerData.connect("score_updated", self, "_update_mirror")
	PlayerData.connect("score_updated", self, "_update_mirror2")
	PlayerData.connect("score_updated", self, "_update_target")
	obstac_number = PlayerData.score
	_update_mirror()
	_update_target()
	_update_mirror2()


func _update_mirror():
	randomize()
	mirror.position = Vector2(mirror_random_generator_number(), obstacle_random_generator_number())
	#mirror.rotation_degrees = - randi()%45 + 90

func _update_mirror2():
	randomize()
	mirror2.position = Vector2(620, obstacle_random_generator_number())

#func mirror_creation():
#	var mirror_instance = mirror2.instance()
#	mirror_instance.position = Vector2(randi()%30 + 600,obstacle_random_generator_number())
#	get_parent().call_deferred("add_child",mirror_instance)


func _update_target():
	randomize()
	target.position = Vector2(randi()%180 + 770, randi()%500 + 50)

func mirror_random_generator_number():
	randomize()
	var random =randi()%450
	if random >=280 and random<=450:
		random += 170
	return random

func obstacle_random_generator_number():
	randomize()
	var random = randi()%500 + 30
	if random >= 270 and random <= 330 :
		random += 60
	return random 
