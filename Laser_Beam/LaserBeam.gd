extends Node2D

var MAX_BOUNCES = 5
const MAX_LENGTH=2000
var death_time = 0


onready var beam = $Beam
onready var end = $End
onready var raycast2D = $RayCast2D
onready var line = $Line2D
onready var line_ray=$Line_Ray
onready var end_line = $Line_Ray/End2


func _process(_delta):
	line.clear_points()
	raycast2D.visible = true
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		raycast2D.visible = false
		line.add_point(Vector2.ZERO)

		
		line_ray.global_position = line.global_position
		line_ray.cast_to = (get_global_mouse_position() - line.global_position).normalized()*2000
		line_ray.force_raycast_update()
		
		var previous = null
		var bounces = 0
		
		while true:
			if not line_ray.is_colliding():
				var pt = line_ray.global_position + line_ray.cast_to
				line.add_point(line.to_local(pt))
				break
			
			var coll = line_ray.get_collider()
			var pt = line_ray.get_collision_point()
			
			
			line.add_point(line.to_local(pt))
			
			if coll.is_in_group("Mirrors"): #if it didnt hit mirror check for prism
				var normal = line_ray.get_collision_normal()  #to make sure on which angle we are colliding
				if normal == Vector2.ZERO:
					break                        #if collider starts out inside of hitbox or something similar
				#update collisions
				if previous !=null:
					previous.collision_mask = 3
					previous.collision_layer = 3
				previous = coll
				previous = previous_setter(previous)
				line_ray.global_position = pt
				line_ray.cast_to = line_ray.cast_to.bounce(normal)
				line_ray.force_raycast_update()
			elif coll.is_in_group("Prism"):
				var normal = line_ray.get_collision_normal()  #to make sure on which angle we are colliding
				if normal == Vector2.ZERO:
					break                        #if collider starts out inside of hitbox or something similar
				#update collisions
				if previous !=null:
					previous.collision_mask = 3
					previous.collision_layer = 3
				previous = coll
				if coll.collision_layer==6:
					previous = previous_setter(previous)
					line_ray.global_position = pt
					line_ray.rotation_degrees =0
					line_ray.force_raycast_update()
				elif coll.collision_layer == 7:
					previous = previous_setter(previous)
					line_ray.global_position = pt
					#line_ray.rotation_degrees =2 * calculate_angle(SingletonScript.nWater)
					line_ray.rotation_degrees = calc_angle(line_ray.cast_to,normal,SingletonScript.nWater)
					line_ray.force_raycast_update()
				elif coll.collision_layer == 8:
					previous = previous_setter(previous)
					line_ray.global_position = pt
					#line_ray.rotation_degrees =2 * calculate_angle(SingletonScript.nGlass)
					line_ray.rotation_degrees = calc_angle(line_ray.cast_to,normal,SingletonScript.nGlass)
					line_ray.force_raycast_update()
				elif coll.collision_layer == 9:
					previous = previous_setter(previous)
					line_ray.global_position = pt
					#line_ray.rotation_degrees =2 * calculate_angle(SingletonScript.nDiamond)
					line_ray.rotation_degrees = calc_angle(line_ray.cast_to,normal,SingletonScript.nDiamond)
					line_ray.force_raycast_update()
				else:
					previous = previous_setter(previous)
					line_ray.global_position = pt
					#line_ray.rotation_degrees =2 * calculate_angle(SingletonScript.nGermanium)
					line_ray.rotation_degrees =2 * calc_angle(line_ray.cast_to,normal,SingletonScript.nGermanium)
					line_ray.force_raycast_update()
			else: 
				break
			bounces += 1
			if bounces >= MAX_BOUNCES:
				break

		if previous !=null:
			previous.collision_mask = 3
			previous.collision_layer = 3
		line_ray.rotation_degrees = 0


#za ulipsat kod malo kod
func previous_setter(previous : CollisionObject2D) -> CollisionObject2D:
	previous.collision_layer = 0
	previous.collision_mask = 0
	return previous


func calculate_angle(n):
	var degree = raycast2D.cast_to.angle_to(Vector2(-1,0))
	if degree <=0:
		var angle
		angle =  1/sin(1/n)
		return angle
	else:
		var angle
		angle = -1/sin(1/n)
		return angle
#ne valja jer prvo triba poslat v
func calc_angle(vec : Vector2,normal : Vector2,n):
	var degree = raycast2D.cast_to.angle_to(Vector2(1,0))
	#print(degree)
	#degree = degree*180/PI
	var angle
	if degree != 0:
		angle = rad2deg(asin(sin(degree)/n))
		#print(180*degree/PI," ", angle, " sindegree ",sin(degree)," asin ", asin(sin(degree)/n))
		return angle
	else:
		return 0

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
	if line_ray.is_colliding():
		var coll = line_ray.get_collider()
		if SingletonScript.LEVEL >= 50:
			PlayerData.score +=1
			SingletonScript.LEVEL = 0
			self.queue_free()
		if death_time >=50:
			PlayerData.death +=1
			death_time = 0
			line.clear_points()
		if coll.is_in_group("Target") and Input.is_mouse_button_pressed(BUTTON_RIGHT):
			SingletonScript.LEVEL += 1
		elif coll.is_in_group("Mirrors"):
			pass
		elif Input.is_mouse_button_pressed(BUTTON_RIGHT):
			death_time +=1
