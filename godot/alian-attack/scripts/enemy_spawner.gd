extends Node2D

signal enem_spawned(enemy_instance: Enemy)

var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")
@onready var spawn_positions: Node2D = $SpawnPositions

func spawn_enemy() -> void:
	var random_spaw_positions = spawn_positions.get_children().pick_random() as Marker2D
	var enemy_instance = enemy_scene.instantiate() as Enemy
	enemy_instance.global_position = random_spaw_positions.global_position
	emit_signal("enem_spawned", enemy_instance)

func _on_timer_timeout() -> void:
	spawn_enemy()
