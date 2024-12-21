extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Here handle everything we need to load!
	# Placeholder 2s wait
	await get_tree().create_timer(2).timeout
	# Then play the anim
	$AnimationPlayer.play("logo")
	
func _unhandled_input(event):
	var main_menu = load("res://scenes/main_menu.tscn")
	Transitioner.fadeTransition(main_menu)

func _on_animation_player_animation_finished(anim_name):
	var main_menu = load("res://scenes/main_menu.tscn")
	Transitioner.fadeTransition(main_menu)

func playSound():
	var randomPitch = randi() % 100 + 50
	var randomPitchFloat : float = float(randomPitch) / 100.0
	print(randomPitchFloat)
	$AudioStreamPlayer.pitch_scale = randomPitchFloat
	$AudioStreamPlayer.play()
