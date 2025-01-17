extends Node2D

@onready var _game_over_menu: CenterContainer = $CanvasLayer/GameOverMenu
@onready var _enemy_spawner: EntitySpawner = $EnemySpawner
@onready var _health_potion_spawner: EntitySpawner = $HealtSpawner

func _on_player_died() -> void:
	print("умер блять")
	_enemy_spawner.stop_timer()
	_game_over_menu.show()
	_health_potion_spawner.stop_timer()
