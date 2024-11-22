extends Node

@onready var main_menu = $CanvasLayer/MainMenu
@onready var addres_entry = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer/AddressEntry

const Player = preload("res://player.tscn")
const PORT = 9999
const DEFAULT_SERVER_IP = "127.0.0.1" # IPv4 localhost

var enet_peer = ENetMultiplayerPeer.new()

@warning_ignore("unused_parameter")
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _test(peer_id) -> void:
	print(peer_id)
	add_player(peer_id)

func _on_host_button_pressed() -> void:
	print("click _on_host_button_pressed")
	main_menu.hide()
	
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(_test)
	
	add_player(multiplayer.get_unique_id())

func _on_join_button_pressed() -> void:
	print("click _on_join_button_pressed")
	main_menu.hide()
	
	enet_peer.create_client(DEFAULT_SERVER_IP, PORT)
	multiplayer.multiplayer_peer = enet_peer

func add_player(peer_id):
		var player = Player.instantiate()
		player.name = str(peer_id)
		add_child(player)
