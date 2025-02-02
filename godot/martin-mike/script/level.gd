extends Node2D

@onready var startPosition: Marker2D = $StartPosition

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_death_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		body.velocity = Vector2.ZERO
		body.global_position = startPosition.global_position
