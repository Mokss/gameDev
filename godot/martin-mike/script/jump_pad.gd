extends Area2D

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

@export var jump_velocity = 500

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animatedSprite.play("jump")
		body.jump(jump_velocity)
