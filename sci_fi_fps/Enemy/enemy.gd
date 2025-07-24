class_name Enemy
extends CharacterBody3D

const SPEED = 5.0

@export var attack_range: float = 1.5
@export var max_hitpoints: int = 100
@export var attack_damage: int = 20

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var player: Player
var provoked: bool = false
var agro_range: float = 12.0
var hitpoints: int = max_hitpoints:
	set(value):
		hitpoints = value
		if hitpoints <= 0:
			queue_free()
		provoked = true

func _ready() -> void:
	player = get_tree().get_first_node_in_group('player') 


func _process(_delta: float) -> void:
	if provoked:
		navigation_agent_3d.target_position = player.global_position


func _physics_process(delta: float) -> void:
	var next_position: Vector3 = navigation_agent_3d.get_next_path_position()
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction: Vector3 = global_position.direction_to(next_position)
	var distance: float  = global_position.distance_to(player.global_position)
	var delta_pos: float = next_position.y - global_position.y
	
	if delta_pos > 0.5 and is_on_floor():
		velocity.y = sqrt(1.0 * 2.0 * -get_gravity().y)

	if distance <= agro_range:
		provoked = true
	
	if provoked:
		if distance <= attack_range:
			animation_player.play("Attack")
 

	if direction:
		look_at_target(direction)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	@warning_ignore("return_value_discarded")
	move_and_slide()


func look_at_target(direction: Vector3) -> void:
	var next_pos: Vector3 = navigation_agent_3d.get_next_path_position()
	next_pos.y = global_transform.origin.y
	var delta: Vector3 = next_pos - global_transform.origin
	if delta.length_squared() > 0.001:
		var adjusted_direction: Vector3 = direction
		adjusted_direction.y = 0
		look_at(global_position + adjusted_direction, Vector3.UP, true)
		

func attack() -> void:
	print("Ennemy Attacked")		
	player.hitpoints -= attack_damage
