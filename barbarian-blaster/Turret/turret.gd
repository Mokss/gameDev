class_name Turret extends Node3D

@export var projectile: PackedScene
@export var turret_range:  float = 10.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cannon: Node3D = $TurretBase/TurretTop/Cannon
@onready var turret_base: Node3D = $TurretBase

var enemy_path: Path3D
var target: Enemy = null

func _physics_process(_delta: float) -> void:
	target = find_best_target()
	if target:
		turret_base.look_at(target.global_position, Vector3.UP, true)

func _on_timer_timeout() -> void:
	if target:
		var shot: Projectile = projectile.instantiate()
		add_child(shot)
		shot.global_position = cannon.global_position
		shot.direction = turret_base.global_transform.basis.z
		animation_player.play("Fire")


func find_best_target() -> Enemy:
	var best_target = null
	var best_progress = 0;
	
	for enemy in enemy_path.get_children():
		if enemy is Enemy:
			if enemy.progress > best_progress:
				var distance := global_position.distance_to(enemy.global_position)
				if distance < turret_range:
					best_target = enemy
					best_progress = enemy.progress
	
	return best_target
