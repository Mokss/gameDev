class_name PathEnemy extends Path2D

@onready var pathFollow: PathFollow2D = $PathFollow2D
@onready var enemy: Enemy = $PathFollow2D/Enemy

func getEnemy() -> Enemy:
	return enemy

func _ready() -> void:
	pathFollow.set_progress_ratio(1)

func _process(delta: float) -> void:
	pathFollow.progress_ratio -= 0.25 * delta

	if pathFollow.progress_ratio == 0:
		queue_free()
