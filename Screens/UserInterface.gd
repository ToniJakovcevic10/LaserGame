extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var score_label: Label = get_node("score")
onready var pause_title: Label = get_node("PauseOverlay/Title")

const die_message: String = "You failed :("
var paused: = false setget set_paused

func _ready() ->void:
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_PlayerData_player_died")
	update_interface()

func set_paused(value: bool) ->void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func update_interface() ->void: 
	score_label.text = "Score: %s" % PlayerData.score
	if PlayerData.score != 0:
		get_tree().change_scene("res://Screens/Level_Passed_Screen.tscn")

func _PlayerData_player_died() ->void: 
	self.paused = true
	pause_title.text = die_message

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and pause_title.text != die_message:
		self.paused = not paused
		scene_tree.set_input_as_handled()
