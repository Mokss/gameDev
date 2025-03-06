extends PathFollow3D

@export var speed: float = 2.5

func _process(delta: float) -> void:
	progress += delta * speed
