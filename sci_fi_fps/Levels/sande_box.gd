extends Node3D

var can_reload: bool = true

func _input(event: InputEvent) -> void:
	print("input frame start")
	# Это полный буул щит, для избежания багов в Windows
	# Windows в Godot 4, InputMap после reload_current_scene() не полностью очищаются
	# и just_pressed не срабатывает при удержании клавиши между перезагрузками.
	if event is InputEventKey and not event.pressed and not event.echo:
		if event.keycode in [KEY_R, KEY_ALT]:
			print("Modifier or R released")
			can_reload = true
	
	if can_reload && Input.is_action_just_pressed("reload_thene"):
		print('reload')
		await get_tree().process_frame
		@warning_ignore("return_value_discarded")
		get_tree().reload_current_scene()
	
	if event is InputEventMouseButton && Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
