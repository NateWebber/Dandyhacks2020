extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO

var jumping = true
var dir_last_moved = "Right"

const max_speed = 60
const acceleration = 1200
const UP_DIRECTION = Vector2.UP
const gravity = 10
const SNAP_DIRECTION = Vector2.DOWN
const SNAP_LENGTH = 8
var snap_vector = SNAP_DIRECTION * SNAP_LENGTH

func reset_snap_vector():
	snap_vector = SNAP_DIRECTION * SNAP_LENGTH
const RAMP_MAX_ANGLE = deg2rad(46)


onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")



# Called when the node enters the scene tree for the first time.
func _ready():
	animationTree.active = true # activate the animation tree
	reset_snap_vector()


func _physics_process(delta):
	pass
	#if(is_on_floor()):
	#	jumping = false
	#else:
	#	jumping = true

var input_vector = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	input_vector = Vector2.ZERO
	#input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if(Input.is_action_pressed("ui_right")):
		input_vector.x += 1
	if(Input.is_action_pressed("ui_left")):
		input_vector.x -= 1
	# grab an input vector based on left and right key input
	#if(input_vector.x < 0):
	#	input_vector.x -= .001
	#else:
	#	input_vector.x += .001
	
	
		
	velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	# if the player should be able to initiate a jump, launch them into the air
	if(Input.get_action_strength("ui_up") > 0) && !jumping:
		velocity.y -= 250
		snap_vector = Vector2.ZERO
		jumping = true
		
	# if moving left or right set animations correspondingly and note the direction we're moving
	if(velocity.x > 0):
		animationState.travel("Run Right")
		dir_last_moved = "Right"
	elif(velocity.x < 0):
		animationState.travel("Run Left")
		dir_last_moved = "Left"
	else: # not moving, so just display the idle animation in the direction last moved
		if(dir_last_moved == "Right"):
			animationState.travel("Idle Right")
		elif(dir_last_moved == "Left"):
			animationState.travel("Idle Left")

	velocity = move_and_slide_with_snap(velocity, snap_vector, UP_DIRECTION, true, 4, RAMP_MAX_ANGLE)
	if(get_slide_count() == 0):
		print(velocity)
		velocity.y += 1200 * delta
		reset_snap_vector()
		
	#velocity.y += 12000 * delta
	for i in range (get_slide_count() - 1):
		var collision = get_slide_collision(i)
		if(collision.collider.to_string().substr(0,8) == "[TileMap"):
			if(velocity.y == 0):
				jumping = false
				reset_snap_vector()
		else:
			velocity.y += 1200 * delta
		print(collision.collider.to_string())
	

