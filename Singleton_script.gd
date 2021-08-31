extends Node2D

onready var opticalmedia = 1
var air = preload("res://Optical_Media/Air/Air.tscn")

#choosing random number
func choosing_random_number():
	randomize()
	opticalmedia = randi() % 2
	print (opticalmedia)
	return 1
