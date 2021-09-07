extends Node2D

var LEVEL = 1
var GAME_LEVEL = 1
var scene_changer = false
onready var opticalmedia = 1

var nAir = 1
var nGlass= 1.458
var nWater = 1.33
var nDiamond = 2.419
var nGermanium = 4.01

onready var scene_tree: = get_tree()
onready var target: Node2D = get_node("res://Target/NodeTarget.tscn")
onready var miror: StaticBody2D = get_node("res://Mirror/Mirror.tscn")

func _ready() ->void:
	PlayerData.connect("score_updated", self, "_update_mirror")
	PlayerData.connect("score_updated", self, "_update_target")


func _update_mirror():
	miror.position = Vector2(randi()%450, randi()%500 + 50)
	miror.rotation_degrees = randi()%360

func _update_target():
	target.position = Vector2(randi()%150 + 800, randi()%500 + 50)

#choosing random number
func choosing_random_number():
	randomize()
	opticalmedia = randi() % 2
	print (opticalmedia)
	return 1

#func prism_creation():
#	var prism_instance = prism.instance()
#	prism_instance.position = Vector2(randi()%400 + 450, 296)
#	get_parent().call_deferred("add_child",prism_instance)
#
#
#func mirror_creation():
#	var mirror_instance = mirror.instance()
#	mirror_instance.position = Vector2(randi()%450,randi()%500 + 50)
#	get_parent().call_deferred("add_child",mirror_instance)
#
