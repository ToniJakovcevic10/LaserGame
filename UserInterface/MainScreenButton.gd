tool
extends Button

export(String, FILE) var next_scene_path :  = ""

func _on_button_up():
	PlayerData.score = 0
	get_tree().paused = false
	get_tree().change_scene(next_scene_path)
	
	

func _get_configuration_warning() -> String:
	return "Next scene path must be set for the button to work" if next_scene_path == "" else ""