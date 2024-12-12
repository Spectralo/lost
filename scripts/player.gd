extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0
const JUMP_BUFFER_TIME = 0.2

@onready var animationTree: AnimationTree = $AnimationTree

var jumpbuffertime : float = 0
var jumping : bool = false

func _enter_tree() -> void:
	jumpbuffertime = 0
	
func _ready() -> void:
	$AnimationTree.active = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		jumpbuffertime = JUMP_BUFFER_TIME
		jumping = true

func _process(delta: float) -> void:
	update_animations_params()
	if jumpbuffertime > 0:
		jumpbuffertime -= delta

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		if jumpbuffertime > 0:
			velocity.y = JUMP_VELOCITY
   
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	# Handle flipping the player depending on direction
	
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction < 0:
		$AnimatedSprite2D.flip_h = true
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func update_animations_params():
	if not velocity:
		print("idle")
		animationTree["parameters/conditions/isIdle"] = true
		animationTree["parameters/conditions/isMoving"] = false
	elif not jumping:
		print("moving :/")
		animationTree["parameters/conditions/isIdle"] = false
		animationTree["parameters/conditions/isMoving"] = true
	if jumping:
		print("jumping!")
		if is_on_floor():
			animationTree["parameters/conditions/jumpEnded"] = true  
			animationTree["parameters/conditions/jumping"] = false
			jumping = false
		else:
			animationTree["parameters/conditions/jumpEnded"] = false
			animationTree["parameters/conditions/jumping"] = true
