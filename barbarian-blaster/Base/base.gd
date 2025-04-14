class_name Base extends Node3D

@export var max_health: int = 5
@onready var label_3d: Label3D = $Label3D

var current_healt: int:
	set(health_in):
		current_healt = health_in
		label_3d.text = str(current_healt) + "/" + str(max_health)

		var red = Color.RED
		var white = Color.WHITE
		var blended_color = red.lerp(white, float(current_healt) / float(max_health))
		label_3d.modulate = blended_color
		
		if current_healt < 1:
			get_tree().reload_current_scene()

func _ready() -> void:
	current_healt = max_health
	Engine.time_scale = 10

func take_damage() -> void:
	current_healt -= 1
