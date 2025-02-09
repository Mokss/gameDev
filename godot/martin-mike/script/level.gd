extends Node2D

@export var next_level: PackedScene = null
@export var level_time: int = 5

@onready var startPosition: Start = $Start
@onready var player: Player = $Player
@onready var exit: Exit = $Exit
@onready var death_zone: Area2D = $DeathZone
@onready var hud: HUD = $UIlayer/HUD
@onready var uILayer: UILayer = $UIlayer

var timer_node: Timer = null
var time_left: int
var win: bool = false

func _ready() -> void:
	player.active = true
	player.global_position = startPosition.getSpawnPosition()
	var traps := get_tree().get_nodes_in_group("traps")
	
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)

	exit.body_entered.connect(_on_exit_body_intered)
	death_zone.body_entered.connect(_on_death_zone_body_entered)

	time_left = level_time
	hud.set_time_label(time_left)

	timer_node = Timer.new()
	timer_node.name = "level timer"
	timer_node.wait_time = 1
	add_child(timer_node)
	timer_node.timeout.connect(_on_level_timer_timeout)
	timer_node.start()

func _on_level_timer_timeout():
	if win == false:
		time_left -= 1
		hud.set_time_label(time_left)
		if time_left < 0:
			AudioPlayer.play_sfx("hurt")
			reset_player()
			time_left = level_time
			hud.set_time_label(time_left)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_death_zone_body_entered(_body: Node2D) -> void:
	AudioPlayer.play_sfx("hurt")
	reset_player()


func _on_trap_touched_player() -> void:
	AudioPlayer.play_sfx("hurt")
	reset_player()


func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = startPosition.getSpawnPosition()

func _on_exit_body_intered(body: Node2D) ->  void:
	if body is Player:
		exit.animate()
		player.active = false
		win = true
		await get_tree().create_timer(1,5).timeout
		
		if next_level != null:
			print(next_level)
			print("NE NULL EPTA")
			get_tree().change_scene_to_packed(next_level)
		else:
			print("NULL EPTA")
			uILayer.show_win_screen(true)
