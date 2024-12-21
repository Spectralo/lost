extends Node2D

func _on_killer_area_body_entered(body):
	if body.is_in_group("player"):
		print("Player killed, resetting position.")
		body.global_position = Global.lastCheckpoint
		body.velocity = Vector2()
