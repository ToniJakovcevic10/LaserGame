extends Area2D

var density = 1
var count_score = 1
onready var slider = $HSlider
onready var coll_prism = $prism_coll_left
onready var textlabel = $Label2

func slider_value():
	density = slider.value
	if slider.value == 1:
		self. collision_layer = 6
		textlabel.text = "Air"
	elif slider.value == 2:
		self.collision_layer = 7
		textlabel.text = "Water"
	elif slider.value == 3:
		self.collision_layer = 8
		textlabel.text = "Glass"
	elif slider.value == 4:
		self.collision_layer = 9
		textlabel.text = "Diamond"
	elif slider.value == 5:
		self.collision_layer = 10
		textlabel.text = "Germanium"

func _process(_delta):
	slider_value()
	if count_score != PlayerData.score:
		slider.value = SingletonScript.choosing_random_number()
		count_score = PlayerData.score
