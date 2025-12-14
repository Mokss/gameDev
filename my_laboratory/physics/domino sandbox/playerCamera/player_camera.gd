class_name PlayerCamera extends CharacterBody3D

@export_range(0.02, 0.1) var lookaround_speed: float = 0.02
@export_range(1.0, 10.0, 0.5) var SPEED:  = 5.0

@onready var ray_cast_3d: RayCast3D = $RayCast3D

var gi: GLOBAL_INPUT
var yaw: float = 0.0
var pitch: float = 0.0

enum Action { LEFT_CLICK, RIGHT_CLICK }

signal onPlayerAction(target: Node3D, ray_cast_3d: RayCast3D, action: Action)

func playerAction(event: Action) -> void:
	if ray_cast_3d.is_colliding():
		var collider: Node3D = ray_cast_3d.get_collider()
		emit_signal("onPlayerAction", collider, ray_cast_3d, event)

func _ready() -> void:
	gi = GLOBAL_INPUT.new(get_tree())
	yaw = rad_to_deg(rotation.y)
	pitch = rad_to_deg(rotation.x)


func _input(event):
	gi.global_input(event)

	if event is InputEventMouseMotion:
		yaw -= event.relative.x * lookaround_speed
		pitch -= event.relative.y * lookaround_speed
		pitch = clamp(pitch, -90, 90)

		rotation.y = deg_to_rad(yaw)
		rotation.x = deg_to_rad(pitch)

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed('left_click'):
		playerAction(Action.LEFT_CLICK)
	elif Input.is_action_pressed('right_click'):
		playerAction(Action.RIGHT_CLICK)

	var curr_speed = SPEED
	if Input.is_action_pressed("speed_up"):
		curr_speed = curr_speed * 2

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")

	var direction = Vector3.ZERO

	if input_dir.length() > 0:
		input_dir = input_dir.normalized()

		# Движение вперёд/назад и влево/вправо относительно камеры
		direction += global_transform.basis.z * input_dir.y   # Вперёд/назад
		direction += global_transform.basis.x * input_dir.x          # Влево/вправо

	# Нормализация направления
	if direction != Vector3.ZERO:
		direction = direction.normalized()

	velocity = direction * curr_speed

	move_and_slide()
