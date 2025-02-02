class_name Player extends CharacterBody2D

const SPEED: float = 18000.0
const JUMP_VELOCITY: float = 400.0

@onready var animationSprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump(JUMP_VELOCITY)

	var direction := Input.get_axis("move_letft", "move_right")
	velocity.x = direction * SPEED * delta
	move_and_slide()
	
	updateAnimation(direction)


func updateAnimation(direction: int):
	if is_on_floor():
		if direction == 0:
			animationSprite.play("idle")
		else:
			animationSprite.play("run")
	else:
		if velocity.y < 0:
			animationSprite.play("jump")
		else:
			animationSprite.play("fail")

	if direction != 0:
			animationSprite.flip_h = direction == -1


func jump(jump_velocity: int):
	velocity.y = -jump_velocity
