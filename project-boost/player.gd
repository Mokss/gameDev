extends RigidBody3D

@export var thrust: float = 1000.0
@export var torque_thrust: float = 100.0

var is_transitioning: bool = false

func _process(delta: float) -> void:
	if (Input.is_action_pressed("boost")):
		apply_central_force(basis.y * delta * thrust)
	if (Input.is_action_pressed("rotate_left")):
		apply_torque(Vector3(0.0, 0.0, torque_thrust * delta))
	if (Input.is_action_pressed("rotate_right")):
		apply_torque(Vector3(0.0, 0.0, -torque_thrust * delta))
	
	if (Input.is_action_just_pressed("reload")):
		get_tree().reload_current_scene()


func _on_body_entered(body: Node) -> void:
	if is_transitioning == false:
		var groups: Array[StringName] = body.get_groups()
		print(groups)
		
		if body is LandingPad:
			print("you win")
			success(body.file_path)
		
		if "Hazard" in groups:
			crash()

func crash() -> void:
	is_transitioning = true
	set_process(false)
	var tween: Tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(get_tree().reload_current_scene)

func success(next_file_path: String) -> void:
	is_transitioning = true
	set_process(false)
	var tween: Tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_file_path))
