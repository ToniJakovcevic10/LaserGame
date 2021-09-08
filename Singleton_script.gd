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



#choosing random number
func choosing_random_number():
	randomize()
	opticalmedia = randi() % 5
	return (opticalmedia + 1)


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
