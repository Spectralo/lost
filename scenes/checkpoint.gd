extends Node2D
var activated = false


func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and not activated:
		Global.lastCheckpoint.x = $Area2D/CollisionShape2D.global_position.x
		Global.lastCheckpoint.y = $Area2D/CollisionShape2D.global_position.y
		$AnimatedSprite2D.play("opening")
		Transitioner.checkpoint()
		activated = true
