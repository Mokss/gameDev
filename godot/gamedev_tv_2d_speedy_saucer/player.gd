extends CharacterBody2D

@export var speed = 24000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO;
	
	if Input.is_action_pressed('move_right'):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed('move_down'):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	velocity = velocity.normalized() * speed * delta
	
	# оптикаем предметы с которыми коллизия
	move_and_slide()
	
