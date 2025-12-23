extends Node

@export var player: PlayerCamera
@export var DominoSpawner: Node3D
@export var domino_scene: PackedScene

var minRandgeForSpawn: float = 0.3
var lastCoordsSpawnDomino: Vector3 = Vector3(-99999999999.9, -99999999.0, -99999999999.0)
var last_spawn_pos: Vector3
var last_direction := Vector3.FORWARD
var has_last: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.connect('onPlayerAction', onPlayerAction)

func spawn_domino(position: Vector3, direction: Vector3):
	var domino := domino_scene.instantiate() as Domino
	DominoSpawner.add_child(domino)

	domino.global_position = position
	domino.look_at(position + direction, Vector3.UP)

func onPlayerAction(target: Node3D, ray_cast_3d: RayCast3D, action: PlayerCamera.Action) -> void:
	if target.is_in_group("Floor") and action == PlayerCamera.Action.LEFT_CLICK:
		#print("add domino ", minRandgeForSpawn)
		#print("target posotion ", ray_cast_3d.target_position)
		#print("target get_collision_normal ", ray_cast_3d.get_collision_normal())
		#print("target get_collision_point ", ray_cast_3d.get_collision_point())
		#print("###\nEND\n###")
		#
		
		var pos := ray_cast_3d.get_collision_point()

		if not has_last:
			last_spawn_pos = pos
			has_last = true
			return

		if pos.distance_to(last_spawn_pos) < minRandgeForSpawn:
			return

		var dir := (pos - last_spawn_pos).normalized()
		dir = dir.lerp(last_direction, 0.3).normalized()

		spawn_domino(pos, dir)

		last_direction = dir
		last_spawn_pos = pos
		
	elif target.is_in_group("Domino") and action == PlayerCamera.Action.RIGHT_CLICK:
		#print("push domino, make fall")
		var hit_point = ray_cast_3d.get_collision_point()
		var push_dir = (hit_point - player.global_position).normalized()
		target.push(push_dir, hit_point)
