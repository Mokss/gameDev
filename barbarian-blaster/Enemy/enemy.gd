class_name Enemy extends PathFollow3D

@export var speed: float = 2.5

@onready var base: Base = get_tree().get_first_node_in_group('base')

func _process(delta: float) -> void:
	progress += delta * speed
	
	if progress_ratio > 0.98:
		base.take_damage()
		set_process(false)
