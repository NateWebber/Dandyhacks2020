extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var jumping = false
export var run_speed = 100
export var jump_speed = -200#-175
export var gravity = 600
#export var run_speed = 100
#export var jump_speed = -500
#export var gravity = 2400

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")



# Called when the node enters the scene tree for the first time.
func _ready():
	animationTree.active = true # activate the animation tree

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_up")
	
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if(velocity.x > 0):
		animationState.travel("Run Right")
		#dir_last_moved = "Right"
	elif(velocity.x < 0):
		animationState.travel("Run Left")
		#dir_last_moved = "Left"
	#else: # not moving, so just display the idle animation in the direction last moved
		#if(dir_last_moved == "Right"):
		#	animationState.travel("Idle Right")
		#elif(dir_last_moved == "Left"):
		#	animationState.travel("Idle Left")


