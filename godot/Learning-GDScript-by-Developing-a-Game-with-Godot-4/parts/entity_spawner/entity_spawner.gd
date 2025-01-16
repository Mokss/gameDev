extends Node2D

@export var entity_scene: PackedScene
@export var spawn_interval: float = 1.5

@onready var _positions: Node2D = $Positions
@onready var _spawn_timer: Timer = $SpawnTimer

func start_timer():
	_spawn_timer.start(spawn_interval)

func stop_timer():
	_spawn_timer.stop()

func spawn_entity() -> void:
	var random_position: Marker2D = _positions.get_children().pick_random()
	var new_entity: Node2D = entity_scene.instantiate()
	new_entity.position = random_position.position
	add_child(new_entity)


func _on_spawn_timer_timeout() -> void:
	spawn_entity()

func _ready():
	start_timer()
