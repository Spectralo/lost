extends Node2D

const PATH_BEGGINING = "res://scenes/levels/level_"

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("swirl")

func _on_area_2d_body_entered(body):
	var levelnumber =  Global.currentLevel
	print(levelnumber)
	var nextscene = PATH_BEGGINING+str(levelnumber+1)+".tscn"
	Global.currentLevel += 1
	Transitioner.portalTransition(load(nextscene))
