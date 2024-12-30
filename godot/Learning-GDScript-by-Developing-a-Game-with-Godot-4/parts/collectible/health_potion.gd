extends Collectible


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.health += 5
	queue_free()
