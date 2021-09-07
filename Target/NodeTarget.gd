extends Node2D

#var direction = Vector2(+1,+1)
#onready var target: = $KinematicBodyTarget
#func _process(delta):
#	target.move_and_slide(direction)
#	if target.is_on_wall():
#		direction.x = -direction.x
#		direction.y += random_direction() - direction.y
#
#
#
#func random_direction():
#	randomize()
#	var rand= randi()%3 - 1
#	return rand
