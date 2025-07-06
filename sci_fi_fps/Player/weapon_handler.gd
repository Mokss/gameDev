extends Node3D


@export var weapon_1: Weapon
@export var weapon_2: Weapon 

func  _ready() -> void:
	equip(weapon_1)


func equip(active_weapon: Weapon) -> void:
	for child in get_children():
		if child == active_weapon:
			if child is Weapon:
				child.visible = true
				child.set_process(true)
				child.ammo_handler.update_ammo_label(child.ammo_type)
				child.ammo_handler.last_ammo_type = child.ammo_type
				
			else:
				push_error("В WeaponHandler в качестве дочерних компонентов оказался не объект Weapon")
		else:
			child.visible = false
			child.set_process(false)


func get_current_index() -> int:
	for index in get_child_count():
		if get_child(index).visible:
			return index
	return 0 


func next_weapon() -> void:
	var index: int = get_current_index()
	index = wrapi(index + 1, 0, get_child_count())
	equip(get_child(index))

func last_weapon() -> void:
	var index: int = get_current_index()
	index = wrapi(index - 1, 0, get_child_count())
	equip(get_child(index))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('weapon_1'):
		equip(weapon_1)
	elif  event.is_action_pressed("weapon_2"):
		equip(weapon_2)
	elif event.is_action_pressed("next_weapon"):
		next_weapon()
	elif event.is_action_pressed('last_weapon'):
		last_weapon()
