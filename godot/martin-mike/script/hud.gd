class_name HUD extends Control

@onready var timeLabel: Label = $TimeLabel

func set_time_label(value: int):
	timeLabel.text = "Time: " + str(value)
