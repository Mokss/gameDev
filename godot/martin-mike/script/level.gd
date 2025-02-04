extends Node2D

@onready var startPosition: Marker2D = $StartPosition
@onready var player: Player = $Player

func _ready() -> void:
	var traps := get_tree().get_nodes_in_group("traps")
	
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)


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
	player.global_position = startPosition.global_position
