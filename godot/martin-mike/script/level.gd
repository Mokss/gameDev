extends Node2D

@export var next_level: PackedScene = null

@onready var startPosition: Start = $Start
@onready var player: Player = $Player
@onready var exit: Exit = $Exit
@onready var death_zone: Area2D = $DeathZone

func _ready() -> void:
	player.active = true
	player.global_position = startPosition.getSpawnPosition()
	var traps := get_tree().get_nodes_in_group("traps")
	
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)

	exit.body_entered.connect(_on_exit_body_intered)
	death_zone.body_entered.connect(_on_death_zone_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_death_zone_body_entered(_body: Node2D) -> void:
	reset_player()


func _on_trap_touched_player() -> void:
	reset_player()


func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = startPosition.getSpawnPosition()

func _on_exit_body_intered(body: Node2D) ->  void:
	if body is Player and next_level != null:
		exit.animate()
		player.active = false
		await get_tree().create_timer(1,5).timeout
		get_tree().change_scene_to_packed(next_level)
