extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Here handle everything we need to load!
	# Placeholder 2s wait
	await get_tree().create_timer(2).timeout
	$Control/AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animated_sprite_2d_animation_looped() -> void:
	$Control/AnimatedSprite2D.stop()
	# Static for 1s
	$Control/AnimatedSprite2D.play("static")
	await get_tree().create_timer(1).timeout
	queue_free()
	
