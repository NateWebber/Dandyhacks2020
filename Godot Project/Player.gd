extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO

var jumping = true
var dir_last_moved = "Right"

const max_speed = 60
const acceleration = 1200
const up_direction = Vector2(0, -100)

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
var snap = Vector2(0, 2.5)


# Called when the node enters the scene tree for the first time.
func _ready():
	animationTree.active = true # activate the animation tree

var input_vector = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	# grab an input vector based on left and right key input
	
	
	
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
	
	velocity = move_and_slide_with_snap(velocity, Vector2(0, 100), up_direction, true, 100)		
	
	
	input_vector = Vector2.ZERO
	#print(is_on_floor())
	if(is_on_floor() && jumping):
		jumping = false
	elif(!is_on_floor()):
		input_vector.y += 2.5
	elif jumping:
		input_vector.y += 2.5
