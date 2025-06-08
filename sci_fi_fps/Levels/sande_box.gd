extends Node3D


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("reload_thene"):
		get_tree().reload_current_scene();
	
	if event is InputEventMouseButton && Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
