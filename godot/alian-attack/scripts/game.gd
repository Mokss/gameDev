extends Node2D

var lives = 3
var score = 0

@onready var player: Player = $Player
@onready var hud: Hud = $UI/HUD

func _ready() -> void:
	hud.set_scrore_label(score)

func _on_death_enemy_zone_area_entered(area: Enemy) -> void:
	area.die()

func _on_player_took_damage() -> void:
	lives -= 1

func _on_enemy_spawner_enem_spawned(enemy_instance: Enemy) -> void:
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died() -> void:
	score += 100
	hud.set_scrore_label(score)
