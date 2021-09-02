extends Node2D

var MAX_BOUNCES = 5
const MAX_LENGTH=2000




onready var beam = $Beam
onready var end = $End
onready var raycast2D = $RayCast2D
onready var line = $Line2D
onready var line_ray=$Line_Ray
onready var end_line = $Line_Ray/End2



func _process(_delta):
	line.clear_points()
	
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		line.add_point(Vector2.ZERO)

		
		line_ray.global_position = line.global_position
		line_ray.cast_to = (get_global_mouse_position() - line.global_position).normalized()*2000
		line_ray.force_raycast_update()
		
		var previous = null
		var bounces = 0
		
		while true:
			var check = true
			if not line_ray.is_colliding():
				var pt = line_ray.global_position + line_ray.cast_to
				line.add_point(line.to_local(pt))
				break
			
			var coll = line_ray.get_collider()
			var pt = line_ray.get_collision_point()
			
			
			line.add_point(line.to_local(pt))
			
					
			if not coll.is_in_group("Mirrors"): #if it didnt hit mirror check for prism
				if not coll.is_in_group("Prism"): #if it didnt hit prism break
					break
#				var normal = line_ray.get_collision_normal() #if it did hit prism make refraction
#				if normal == Vector2.ZERO:
#					break
#				#update collisions
#				if previous !=null:
#					previous.collision_mask = 6
#					previous.collision_layer = 6
#				previous = coll
#				#update raycast
#				line_ray.global_position = pt
#				line_ray.rotation += Vector2(1,4).angle() #have to change refraction angle with another func
#				line_ray.cast_to = line_ray.cast_to.bounce(normal)
#				line_ray.force_raycast_update()
#				bounces += 1
#				if bounces >= MAX_BOUNCES:
#					break
				check = false

			if check ==true: #if it hit prism dont have to do all this again
				var normal = line_ray.get_collision_normal()  #to make sure on which angle we are colliding
				if normal == Vector2.ZERO:
					break                        #if collider starts out inside of hitbox or something similar
				#update collisions
				if previous !=null:
					previous.collision_mask = 3
					previous.collision_layer = 3
				previous = coll
				previous.collision_mask = 0
				previous.collision_layer = 0
				#update raycast
				line_ray.global_position = pt
				line_ray.cast_to = line_ray.cast_to.bounce(normal)
				line_ray.force_raycast_update()
				bounces += 1
				if bounces >= MAX_BOUNCES:
					break

		if previous !=null:
			previous.collision_mask = 3
			previous.collision_layer = 3
		line_ray.rotation = 0




#func _physics_process(_delta):
#	var mouse_position = get_local_mouse_position()
#	var max_cast_to = mouse_position.normalized() * MAX_LENGTH
#	raycast2D.cast_to = max_cast_to
#	if raycast2D.is_colliding():
#		end.global_position = raycast2D.get_collision_point()
#
#	else:
#		end.global_position = raycast2D.cast_to
#	beam.rotation = raycast2D.cast_to.angle()
#	beam.region_rect.end.x = end.position.length()


func calculate_angle(angle, size,n):
	angle = angle * PI/180
	
	var fx = size * cos(angle)
	var fy = size * sin(angle)
	


func _on_prism_body_entered(body):
	if body.name == "line_ray":
		var pt = line_ray.get_collision_point()
		line.add_point(line.to_local(pt))
		line_ray.global_position = pt
		line_ray.cast_to = (get_global_mouse_position() - line.global_position).normalized()*2000
		line_ray.rotation_degrees(20)
		line_ray.force_raycast_update()
		
