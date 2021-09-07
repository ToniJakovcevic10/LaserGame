extends Node

signal score_updated
signal player_died


var score := 0 setget set_score
var death := 0 setget set_deaths
var check_score = score


func reset()->void:
	score = 0
	death = 0

func set_score(value: int) ->void:
	score = value
	emit_signal("score_updated")
	check_score = score

func set_deaths(value: int) -> void:
	death = value
	emit_signal("player_died")
