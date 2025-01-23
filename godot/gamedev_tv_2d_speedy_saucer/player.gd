extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_bottom"):
		velocity.y = 100;
	if Input.is_action_pressed("move_top"):
		velocity.y = -100;
	if Input.is_action_just_pressed("move_left"):
		velocity.x = -100;
	if Input.is_action_just_pressed("move_right"):
		velocity.x = 100;
	
	print('Velsicy', velocity)
	
	velocity.normalized()
	
	print('VelosityNormilize', velocity)
	
	move_and_slide()
