extends Control
class_name  GameOverMeny

func game_over() -> void:
	get_tree().paused = true
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	@warning_ignore("return_value_discarded")
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
