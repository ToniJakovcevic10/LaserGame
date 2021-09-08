extends Node2D


var levels_passed = 0

onready var target = $staticBodyTarget

func _process(_delta):
	if PlayerData.score > (levels_passed + 3):
		levels_passed +=3
		if self.scale.x >= 0.2262:
			self.scale.x = 0.85 * self.scale.x
			self.scale.y = 0.85* self.scale.y 
