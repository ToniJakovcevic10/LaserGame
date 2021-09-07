extends Node2D


onready var prism = $prism
onready var mirror = $Mirror



func _physics_process(_delta):
	if SingletonScript.scene_changer ==true:
		SingletonScript.scene_changer = false
		while true:
			prism.position = Vector2(randi()%450 + 350,296)
			mirror.position = Vector2(randi()%400, randi()%450)
			mirror.rotation_degrees = randi()%360
			
		
