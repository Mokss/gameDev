extends Control

@onready var highscore_label: Label = $CenterContainer/MainUiContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/HighscoreLabel

func _ready():
	highscore_label.text = "Highscore: " + str(HighscoreManager.highscore)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/game/main.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
