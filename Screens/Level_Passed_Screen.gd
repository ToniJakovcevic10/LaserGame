extends Control


onready var label: Label = get_node("Level")

func _ready() ->void:
	label.text = label.text % PlayerData.score
