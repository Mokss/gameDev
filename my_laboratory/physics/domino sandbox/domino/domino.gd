extends RigidBody3D

@onready var variants: Node3D = $Variants

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dominos_count: int = variants.get_child_count()
	
	if dominos_count > 0:
		var domino: Node3D = variants.get_child(randi() % dominos_count - 1)
		domino.visible = true
