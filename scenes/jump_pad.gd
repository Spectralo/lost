extends Node2D

func _on_area_2d_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.velocity = Vector2(0,-1000)
