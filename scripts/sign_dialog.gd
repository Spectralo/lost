extends Node2D
@export_file("*.dialogue") var Dialog: String
@export var Name : String
@export var oneTime : bool = true
var onSign = false

func _input(event):
	if Input.is_action_just_pressed("ui_accept") and onSign:
		var balloon = load("res://baloon/balloon.tscn").instantiate()
		get_tree().current_scene.add_child(balloon)
		var resource = load(Dialog)
		balloon.start(resource, Name)
		Global.inDialogue = true


func _on_sign_area_body_entered(body):
	onSign = true


func _on_sign_area_body_exited(body):
	onSign = false
