extends CanvasLayer

func fadeTransition(target: PackedScene) -> void:
	$AnimationPlayer.play("disolve")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(target)
	$AnimationPlayer.play_backwards("disolve")
