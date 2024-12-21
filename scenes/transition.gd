extends CanvasLayer

func fadeTransition(target: PackedScene, speed:float=1) -> void:
	$AnimationPlayer.play("disolve")
	$AnimationPlayer.speed_scale = speed
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(target)
	$AnimationPlayer.play_backwards("disolve")
	
func checkpoint():
	$AnimationPlayer2.play("checkpoint")

func portalTransition(target: PackedScene, speed:float=1) -> void:
	$AnimationPlayer.play("portal")
	$AnimationPlayer.speed_scale = speed
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(target)
	$AnimationPlayer.play_backwards("portal")
