extends Node2D


const MAX_LENGTH=2000

onready var beam = $Beam
onready var end = $End
onready var raycast2D = $RayCast2D

func _physics_process(_delta):
	var mouse_position = get_local_mouse_position()
	var max_cast_to = mouse_position.normalized() * MAX_LENGTH
	raycast2D.cast_to = max_cast_to
	if raycast2D.is_colliding():
		end.global_position = raycast2D.get_collision_point()
	else:
		end.global_position = raycast2D.cast_to
	beam.rotation = raycast2D.cast_to.angle()
	beam.region_rect.end.x = end.position.length()
	
