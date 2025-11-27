extends Node3D
@onready var sphere_one: MeshInstance3D = $SphereExample/SphereOne
@onready var sphere_two: MeshInstance3D = $SphereExample/SphereTwo

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("left_click"):
		var sphere_mat_one: ShaderMaterial = sphere_one.get_active_material(0)
		var sphere_mat_two: ShaderMaterial = sphere_two.get_active_material(0)
		
		var random_color_one = Vector3(randf(), randf(), randf())
		var random_color_two = Vector3(randf(), randf(), randf())
		
		sphere_mat_one.set_shader_parameter("spehere_color", random_color_one);
		sphere_mat_two.set_shader_parameter("spehere_color", random_color_two);
