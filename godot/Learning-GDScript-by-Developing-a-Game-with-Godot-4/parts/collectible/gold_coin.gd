extends Collectible

func _on_area_2d_body_entered(body: Player) -> void:
	body.gold += 5
	queue_free()
