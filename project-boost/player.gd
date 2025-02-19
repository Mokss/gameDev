extends RigidBody3D

@export var thrust: float = 1000.0
@export var torque_thrust: float = 100.0

@onready var explosing_audio: AudioStreamPlayer = $ExplosingAudio
@onready var success_audio: AudioStreamPlayer = $SuccessAudio
@onready var rocket_audio: AudioStreamPlayer3D = $RocketAudio
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var right_booster_particles: GPUParticles3D = $RightBoosterParticles
@onready var left_booster_particles: GPUParticles3D = $LeftBoosterParticles
@onready var success_particles: GPUParticles3D = $SuccessParticles
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles

var is_transitioning: bool = false

func _process(delta: float) -> void:
	if (Input.is_action_pressed("boost")):
		booster_particles.emitting = true
		if rocket_audio.playing == false:
			rocket_audio.play()
		apply_central_force(basis.y * delta * thrust)
	else:
		booster_particles.emitting = false
		rocket_audio.stop()

	if (Input.is_action_pressed("rotate_left")):
		right_booster_particles.emitting = true
		apply_torque(Vector3(0.0, 0.0, torque_thrust * delta))
	else:
		right_booster_particles.emitting = false
		
	if (Input.is_action_pressed("rotate_right")):
		left_booster_particles.emitting = true
		apply_torque(Vector3(0.0, 0.0, -torque_thrust * delta))
	else:
		left_booster_particles.emitting = false
	
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
	explosion_particles.emitting = true
	explosing_audio.play()
	is_transitioning = true
	set_process(false)
	var tween: Tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().reload_current_scene)

func success(next_file_path: String) -> void:
	success_particles.emitting = true
	success_audio.play()
	is_transitioning = true
	set_process(false)
	var tween: Tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_file_path))
