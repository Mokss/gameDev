extends Node

@export var player: PlayerCamera
@export var DominoSpawner: Node3D
@export var domino_scene: PackedScene

var delay_mc = 100
var lastTimeDominoAdded = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.connect('onPlayerAction', onPlayerAction)

func canSpawnNewDomino() -> bool:
	var currTime = Time.get_ticks_msec()
	
	if currTime > lastTimeDominoAdded:
		lastTimeDominoAdded = currTime + delay_mc
		return true

	return false

func spawn_domino(position: Vector3, _normal: Vector3):
	var domino := domino_scene.instantiate() as Domino
	DominoSpawner.add_child(domino)

	domino.global_position = position
	#domino.look_at(position + normal, Vector3.UP)

func onPlayerAction(target: Node3D, ray_cast_3d: RayCast3D, action: PlayerCamera.Action) -> void:
	if target.is_in_group("Floor") and action == PlayerCamera.Action.LEFT_CLICK and canSpawnNewDomino():
		print("add domino")
		print("target posotion", ray_cast_3d.target_position)
		print("target get_collision_normal", ray_cast_3d.get_collision_normal())
		print("target get_collision_point", ray_cast_3d.get_collision_point())
		print("###\nEND\n###")
		
		var pos = ray_cast_3d.get_collision_point()
		var normal = ray_cast_3d.get_collision_normal()

		spawn_domino(pos, normal)
		
	elif target.is_in_group("Domino") and action == PlayerCamera.Action.RIGHT_CLICK:
		print("push domino, make fall")
		var hit_point = ray_cast_3d.get_collision_point()
		var push_dir = (hit_point - player.global_position).normalized()
		target.push(push_dir, hit_point)
	
