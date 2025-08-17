extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("set_speed"):
		var Spritematerial: Material = sprite_2d.material
		if Spritematerial is ShaderMaterial:
			#var new_speed: float = material.get_shader_parameter("my_float") + 1.0
			var new_speed: float = randf_range(1.0, 10.0)
			Spritematerial.set_shader_parameter("my_float", new_speed)
