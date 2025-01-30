class_name Player extends CharacterBody2D

signal took_damage

@export var speed: int = 300;

@onready var collisionShape: CollisionShape2D = $CollisionShape2D
@onready var rocketContainer: Node = $RocketContainer
@onready var screen_size: Vector2 = get_viewport_rect().size

var rocket_scene: PackedScene = load("res://scenes/rocket.tscn")
var charter_height: float = 0
var chartet_width: float = 0
const margin: int = 10;

func _ready() -> void:
	if collisionShape.shape is CapsuleShape2D:
	# Получаем размеры прямоугольника
		var size = collisionShape.shape.get_rect().size
		print("Размер коллизии: ", size)
		
		charter_height = size.y / 2 + margin
		chartet_width = size.x / 2 + margin

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(_delta: float) -> void:
	velocity = Vector2(0,0)
	
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	
	move_and_slide()
	
	global_position.x = clampf(global_position.x, chartet_width, screen_size.x - chartet_width)
	global_position.y = clampf(global_position.y, charter_height, screen_size.y - charter_height)

func shoot() -> void:
	var rocket_instance = rocket_scene.instantiate()
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 80
	rocketContainer.add_child(rocket_instance)

func take_damage() -> void:
	emit_signal("took_damage")
