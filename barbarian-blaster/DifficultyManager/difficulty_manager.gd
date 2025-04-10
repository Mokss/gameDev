class_name DifficultyManager extends Node

@export var game_length: float = 30.0
@export var spawn_timer_curve: Curve
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(game_length);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_progress_ratio() -> float:
	return 1.0 - (timer.time_left / game_length)


func get_spawn_time() -> float:
	return spawn_timer_curve.sample(game_progress_ratio())
