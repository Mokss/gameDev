class_name Player extends CharacterBody2D

const MAX_HEALTH: int = 10

@onready var _health_label: Label = $HealthLabel
@onready var _gold_label: Label = $GoldLabel

@export_range(0, MAX_HEALTH) var health: int = 10:
	get:
		return health
	set(new_value):
		health = clamp(new_value, 0, MAX_HEALTH)
		update_health_label()
@export var gold: int = 0:
	get:
		return gold
	set(new_value):
		gold = clamp(new_value, 0, INF)
		update_gold_label()
@export var max_speed: float = 500.0
@export var acceleration: float = 2500.0
@export var deceleration: float = 1500.0


func _ready():
	update_health_label()
	update_gold_label()


func update_health_label():
	if not is_instance_valid(_health_label):
		return

	_health_label.text = str(health) + "/" + str(MAX_HEALTH)

func update_gold_label():
	if not is_instance_valid(_gold_label):
		return

	_gold_label.text = "gold " + str(gold)

func add_health_points(difference: int):
	health += difference

func _physics_process(delta: float):
	var input_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(input_direction * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)

	move_and_slide()

func get_hit() -> void: 
	health -= 1
	
