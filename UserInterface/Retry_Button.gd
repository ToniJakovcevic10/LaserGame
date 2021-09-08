tool
extends Button

export(String, FILE) var next_scene_path :  = ""

func _get_configuration_warning() -> String:
	return "Next scene path must be set for the button to work" if next_scene_path == "" else ""


func _on_Retry_Button_button_up():
	get_tree().paused = false
	get_tree().change_scene(next_scene_path)
