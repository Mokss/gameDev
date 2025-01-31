extends Node2D

var lives = 3
var score = 0

@onready var player: Player = $Player
@onready var hud: Hud = $UI/HUD
@onready var UI = $UI
@onready var enemyHitSound: AudioStreamPlayer = $EnemyHitSound
@onready var playerHitSound: AudioStreamPlayer = $PlayerHitSound

var gos_scene: PackedScene = preload("res://scenes/game_over.tscn")

func _ready() -> void:
	hud.set_scrore_label(score)
	hud.set_health_label(lives)

func _on_death_enemy_zone_area_entered(area: Enemy) -> void:
	area.silenceDie()

func _on_player_took_damage() -> void:
	playerHitSound.play()
	lives -= 1
	hud.set_health_label(lives)
	if lives == 0:
		player.die()
		
		await  get_tree().create_timer(1.5).timeout
		
		var gos = gos_scene.instantiate()
		gos.set_score(score)
		UI.add_child(gos)

func _on_enemy_spawner_enem_spawned(enemy_instance: Enemy) -> void:
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died() -> void:
	score += 100
	hud.set_scrore_label(score)
	enemyHitSound.play()


func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance: PathEnemy) -> void:
	add_child(path_enemy_instance)
	path_enemy_instance.getEnemy().connect("died", _on_enemy_died)
