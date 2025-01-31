class_name Enemy extends Area2D

signal died

@export var speed: int = 300

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta

func silenceDie() -> void:
	queue_free()

func die() -> void:
	emit_signal("died")
	queue_free()


func _on_body_entered(body: Player) -> void:
	body.take_damage()
	silenceDie()
