extends RigidBody3D
class_name Domino

@export var push_force: float = 0.3

@onready var variants: Node3D = $Variants
@onready var _6_6: Node3D = $"Variants/6_6"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_6_6.visible = false;
	
	var dominos_count: int = variants.get_child_count()
	
	if dominos_count > 0:
		var domino: Node3D = variants.get_child(randi() % dominos_count - 1)
		domino.visible = true


func push(force_dir: Vector3, hit_point: Vector3):
	# Применяем импульс в точке удара
	apply_impulse(force_dir * push_force, hit_point - global_position)
