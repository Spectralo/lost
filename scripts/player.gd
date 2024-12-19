
extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -700.0
const JUMP_BUFFER_TIME = 0.2
const COYOTE_TIME = 0.2
const SLIDE_THRESHOLD = 300.0
const SLIDE_DECELERATION = 2000.0
const ACCELERATION = 2000.0
const GRAVITY = 2000.0
const MAX_FALL_SPEED = 1000.0
const JUMP_CUT_OFF = 0.5

@onready var animationTree: AnimationTree = $AnimationTree

var jumpbuffertime : float = 0
var coyotetime : float = 0
var jumping : bool = false

func _enter_tree() -> void:
	jumpbuffertime = 0

func _ready() -> void:
	$AnimationTree.active = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= JUMP_CUT_OFF

	if Input.is_action_just_pressed("jump"):
		jumpbuffertime = JUMP_BUFFER_TIME
		jumping = true

func _process(delta: float) -> void:
	update_coyot_time(delta)
	update_animations_params()
	if jumpbuffertime > 0:
		jumpbuffertime -= delta

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y > MAX_FALL_SPEED:
			velocity.y = MAX_FALL_SPEED

	if is_on_floor():
		coyotetime = COYOTE_TIME

	if (jumpbuffertime > 0 and coyotetime > 0):
		velocity.y = JUMP_VELOCITY
		jumpbuffertime = 0
		coyotetime = 0

	var direction := Input.get_axis("left", "right")

	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction < 0:
		$AnimatedSprite2D.flip_h = true

	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		if abs(velocity.x) > SLIDE_THRESHOLD:
			velocity.x = move_toward(velocity.x, 0, SLIDE_DECELERATION * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)

	move_and_slide()

func update_animations_params():
	if not velocity:
		animationTree["parameters/conditions/isIdle"] = true
		animationTree["parameters/conditions/isMoving"] = false
	elif not jumping:
		animationTree["parameters/conditions/isIdle"] = false
		animationTree["parameters/conditions/isMoving"] = true
	if jumping:
		if is_on_floor():
			animationTree["parameters/conditions/jumpEnded"] = true  
			animationTree["parameters/conditions/jumping"] = false
			jumping = false
		else:
			animationTree["parameters/conditions/jumpEnded"] = false
			animationTree["parameters/conditions/jumping"] = true

func update_coyot_time(delta: float):
	if is_on_floor():
		coyotetime = COYOTE_TIME
	else:
		coyotetime -= delta
