class_name Start extends StaticBody2D

@onready var spawn_pos: Marker2D = $SpawnPosition

func getSpawnPosition() -> Vector2:
	return spawn_pos.global_position
