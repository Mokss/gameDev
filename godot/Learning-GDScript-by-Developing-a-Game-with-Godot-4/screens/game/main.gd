extends Node2D

@onready var _game_over_menu: CenterContainer = $CanvasLayer/GameOverMenu
@onready var _enemy_spawner: EntitySpawner = $EnemySpawner
@onready var _health_potion_spawner: EntitySpawner = $HealtSpawner
@onready var _time_label: Label = $ CanvasLayer/TimerUI/TimeLabel
var _time: float = 0.0:
	set(value):
		_time = value
		_time_label.text = str(floor(_time))

func _on_player_died() -> void:
	_enemy_spawner.stop_timer()
	_game_over_menu.show()
	_health_potion_spawner.stop_timer()
	
	set_process(false)
	@warning_ignore("narrowing_conversion")
	HighscoreManager.set_new_highscore(_time)

func _process(delta: float):
	_time += delta
