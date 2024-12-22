extends Area2D

var mouse_is_here = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	mouse_is_here = true


func _on_mouse_exited():
	mouse_is_here = false
	
func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse_is_here:
		Transitioner.fadeTransition(load("res://scenes/main_menu.tscn"),2)
