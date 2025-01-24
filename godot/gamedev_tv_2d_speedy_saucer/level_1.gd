extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_muzy_body_exited(_body: Node2D) -> void:
	print('oh shiit')
	get_tree().call_deferred("reload_current_scene")
