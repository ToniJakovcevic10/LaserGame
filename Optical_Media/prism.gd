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
		coll_prism.modulate = Color(0, 0, 0, 0.505882)
	elif slider.value == 2:
		self.collision_layer = 7
		textlabel.text = "Water"
		coll_prism.modulate = Color(0.05098, 0.145098, 0.917647)
	elif slider.value == 3:
		self.collision_layer = 8
		textlabel.text = "Glass"
		coll_prism.modulate = Color(0.945098, 1, 0)
	elif slider.value == 4:
		self.collision_layer = 9
		textlabel.text = "Diamond"
		coll_prism.modulate = Color(0.917647, 0.05098, 0.556863)
	elif slider.value == 5:
		self.collision_layer = 10
		textlabel.text = "Germanium"
		coll_prism.modulate = Color(0.019608, 0.360784, 0.070588)

func _process(_delta):
	slider_value()
	if count_score != PlayerData.score:
		slider.value = SingletonScript.choosing_random_number()
		count_score = PlayerData.score
