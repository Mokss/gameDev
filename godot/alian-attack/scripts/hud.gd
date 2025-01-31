class_name Hud extends Control

@onready var scoreLabel: Label = $Score
@onready var healthLabel: Label = $Health

func set_scrore_label(new_score: int):
	scoreLabel.text = "Score: " + str(new_score)

func set_health_label(new_health: int):
	healthLabel.text = str(new_health)
