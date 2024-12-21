extends Node2D
@export_file("*.dialogue") var Dialog: String
@export var Name : String
@export var oneTime : bool = true

func _on_area_2d_body_entered(body):
	print("We did hit it")
	var balloon = load("res://baloon/balloon.tscn").instantiate()
	get_tree().current_scene.add_child(balloon)
	var resource = load(Dialog)
	balloon.start(resource, Name)
	Global.inDialogue = true
	if oneTime:
		queue_free()
