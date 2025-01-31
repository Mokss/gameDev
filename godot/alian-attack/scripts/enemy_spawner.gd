extends Node2D

signal enem_spawned(enemy_instance: Enemy)
signal path_enemy_spawned(path_enemy_instance: PathEnemy)

var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")
var enemy_path_scene: PackedScene = preload("res://scenes/path_enemy.tscn")

@onready var spawn_positions: Node2D = $SpawnPositions

func spawn_enemy() -> void:
	var random_spaw_positions = spawn_positions.get_children().pick_random() as Marker2D
	var enemy_instance = enemy_scene.instantiate() as Enemy
	enemy_instance.global_position = random_spaw_positions.global_position
	emit_signal("enem_spawned", enemy_instance)

func _on_timer_timeout() -> void:
	spawn_enemy()


func _on_path_enemy_timer_timeout() -> void:
	var path_eneme_intance = enemy_path_scene.instantiate() as PathEnemy
	emit_signal("path_enemy_spawned", path_eneme_intance)
