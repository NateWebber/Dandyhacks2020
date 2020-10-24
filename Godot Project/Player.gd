extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO

var jumping = true
var dir_last_moved = "Right"

const max_speed = 60
const acceleration = 1200
const up_direction = Vector2(0, -1)

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")


# Called when the node enters the scene tree for the first time.
func _ready():
	animationTree.active = true # activate the animation tree


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	# grab an input vector based on left and right key input
	
	#if the player should be falling, apply gravity
	if jumping or (!is_on_floor()):
		input_vector.y = 2.5
	
	velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	
	# if the player should be able to initiate a jump, launch them into the air
	if(Input.get_action_strength("ui_up") > 0) && !jumping:
		velocity.y -= 250
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
	
	velocity = move_and_slide(velocity, up_direction, true, 4)
	
	if(velocity.y == 0):
		jumping = false
	
