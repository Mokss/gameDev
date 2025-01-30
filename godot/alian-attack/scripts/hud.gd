class_name Hud extends Control

@onready var scoreLabel: Label = $Score

func set_scrore_label(new_score: int):
	scoreLabel.text = "Score: " + str(new_score)
