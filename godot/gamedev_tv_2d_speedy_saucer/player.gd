extends CharacterBody2D

@export var speed = 400
var start_borders
var end_borders
# Called when the node enters the scene tree for the first time.
func _ready():
	start_borders = Vector2(27, 34)
	end_borders = get_viewport_rect().size - start_borders

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

	velocity = velocity.normalized() * speed
	
	# оптикаем предметы с которыми коллизия
	move_and_slide()
	# не даем выйти за рамки экрана
	position = position.clamp(start_borders, end_borders)
	
