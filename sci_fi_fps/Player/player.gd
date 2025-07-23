class_name Player extends CharacterBody3D


@export var speed: float = 8.0
@export var jump_height: float = 1.0
@export var fall_multiplier: float = 2.0
@export var max_hitpoints: int = 100
@export var aim_multiplier: float = 0.7

@onready var camera_pivot: Node3D = $CameraPivot
@onready var animation_player: AnimationPlayer = $DamageTexture/AnimationPlayer
@onready var game_over_menu: GameOverMeny = $GameOverMenu
@onready var ammo_handler: AmmoHandler = %AmmoHandler
@onready var smooth_camera: Camera3D = %SmoothCamera
@onready var weapon_camera: Camera3D = %WeaponCamera
@onready var smooth_camera_fov: float = smooth_camera.fov
@onready var weapon_camera_fov: float = weapon_camera.fov


var mouse_motion: Vector2 = Vector2.ZERO
var hitpoints: int = max_hitpoints:
	set(value):
		if value < hitpoints:
			animation_player.stop(false)
			animation_player.play('TakeDamage')
		hitpoints = value
		print("PLayer " + str(hitpoints))
		if hitpoints <= 0:
			@warning_ignore("return_value_discarded")
			game_over_menu.game_over()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta: float) -> void:
	if Input.is_action_pressed("aim"):
		smooth_camera.fov = lerp(smooth_camera.fov, smooth_camera_fov * aim_multiplier, delta * 20.0)
		weapon_camera.fov = smooth_camera.fov
	else:
		smooth_camera.fov = smooth_camera_fov
		weapon_camera.fov = weapon_camera_fov


func _physics_process(delta: float) -> void:
	handle_camera_rotation()
	# Add the gravity.
	if not is_on_floor():
		if velocity.y >= 0:
			velocity += get_gravity() * delta
		else:
			velocity.y += get_gravity().y * delta * fall_multiplier

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = sqrt(jump_height * 2.0 * -get_gravity().y)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		if Input.is_action_pressed("aim"):
			velocity.x *= aim_multiplier
			velocity.z *= aim_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	@warning_ignore("return_value_discarded")
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion &&  Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			mouse_motion = -event.relative * 0.001
			if Input.is_action_pressed("aim"):
				mouse_motion *= aim_multiplier


func handle_camera_rotation() -> void:
	rotate_y(mouse_motion.x)
	camera_pivot.rotate_x(mouse_motion.y)
	camera_pivot.rotation_degrees.x = clampf(camera_pivot.rotation_degrees.x, -90.0, 90.0)
	mouse_motion = Vector2.ZERO
