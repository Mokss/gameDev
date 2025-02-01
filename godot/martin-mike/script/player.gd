class_name Player extends CharacterBody2D

const SPEED: float = 18000.0
const JUMP_VELOCITY: float = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_letft", "move_right")
	velocity.x = direction * SPEED * delta
	

	move_and_slide()
