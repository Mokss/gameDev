extends Camera3D

@export var speed: float = 44.0

func _physics_process(delta: float) -> void:
	var weight: float = clamp(delta * speed, 0.0, 1.0)
#	
	var parent: Node3D = get_parent()
	
	if parent is Node3D:
		global_transform = global_transform.interpolate_with(parent.global_transform, weight)
		global_position = parent.global_position
