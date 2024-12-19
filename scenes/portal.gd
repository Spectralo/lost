extends Node2D

const PATH_BEGGINING = "res://scenes/levels/level_"

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("swirl")

func _on_area_2d_body_entered(body):
	var levelnumber =  int(get_tree().filename)
	print(levelnumber)
	var nextscene = PATH_BEGGINING+str(levelnumber)+".tscn"
	Transitioner.fadeTransition(load(nextscene))
