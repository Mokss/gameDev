class_name Enemy extends PathFollow3D

@export var speed: float = 5
@export var max_health: int = 50

var current_health: int:
	set(health_in):
		current_health = health_in
		if current_health < 1:
			queue_free()
		
@onready var base: Base = get_tree().get_first_node_in_group('base')

func _ready() -> void:
	current_health = max_health

func _process(delta: float) -> void:
	progress += delta * speed
	
	if progress_ratio > 0.98:
		base.take_damage()
		queue_free()
