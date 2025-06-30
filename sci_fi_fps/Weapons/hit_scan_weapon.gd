extends Node3D
class_name Weapon

# выстрелы в минуту
@export var fire_rate: float = 14.0
@export var recoil: float = 0.05
@export var weapon_mesh: Node3D
@export var weapon_damage: int = 15
@export var muzzle_flash: GPUParticles3D
@export var sparks: PackedScene
@export var automatic: bool = true

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var weapon_position: Vector3 = weapon_mesh.position
@onready var ray_cast_3d: RayCast3D = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if automatic:
		if Input.is_action_pressed("fire"):
			if cooldown_timer.is_stopped():
				shoot()
	else:
		if Input.is_action_just_pressed("fire"):
			if cooldown_timer.is_stopped():
				shoot()

func _physics_process(delta: float) -> void:
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * 6.0)


func shoot() -> void:
	muzzle_flash.restart()
	cooldown_timer.start(1.0 / fire_rate)
	weapon_mesh.position.z += recoil
	var colider: Object = ray_cast_3d.get_collider()
	print("weapon fired", colider)
	
	if colider:
		if colider is Enemy:
			colider.hitpoints -= weapon_damage
		var spark: Node3D = sparks.instantiate()
		add_child(spark)
		
		spark.global_position = ray_cast_3d.get_collision_point()
