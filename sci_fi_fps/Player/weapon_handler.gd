extends Node3D


@export var weapon_1: Weapon
@export var weapon_2: Weapon 


func  _ready() -> void:
	equip(weapon_1)


func equip(active_weapon: Weapon) -> void:
	for child in get_children():
		if child == active_weapon:
			child.visible = true
			child.set_process(true)
		else:
			child.visible = false
			child.set_process(false)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('weapon_1'):
		equip(weapon_1)
	elif  event.is_action_pressed("weapon_2"):
		equip(weapon_2)
