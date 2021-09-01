extends Node2D

onready var opticalmedia = 1  #zbog ovoga se odma pokrene uvik air
#var air = preload("res://Optical_Media/Air/airNode.tscn")

#choosing random number
func choosing_random_number():
	randomize()
	opticalmedia = randi() % 2
	print (opticalmedia)
	return 1
