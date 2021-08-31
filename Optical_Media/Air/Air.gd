extends StaticBody2D

onready var singleton= get_node("/root/SingletonScript")

func _physics_process(_delta):
	if singleton.opticalmedia == 1:
		self.position += Vector2(-2,0)
	if self.position.x <= -2048:
		self.queue_free()
		singleton.opticalmedia = singleton.choosing_random_number()
		air_reset()


func air_reset():
	var air_instance=singleton.air.instance()
	air_instance.position= Vector2(0,0)
	get_parent().call_deferred("add_child",air_instance)
	print("air reset")
