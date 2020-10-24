extends KinematicBody2D

#find the player 
onready var Player = get_parent().get_node("Player")
#animation stuff
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

var vel = Vector2(0, 0)
var up_direction = Vector2(0, -1)

#delay before running at the player
var react_time = 250

#direction handling
var dir = 0
var next_dir = 0
var next_dir_time = 0

#distance from player threshhold before stopping
var offset = 10


#speed modifier
var speed = 50

#func _ready():
	#$CollisionShape2D.disabled = true

func set_dir(target_dir):
	if next_dir != target_dir:
		next_dir = target_dir
		next_dir_time = OS.get_ticks_msec() + react_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Player.position.x < position.x - offset:
		set_dir(-1)
	elif Player.position.x > position.x +  offset:
		set_dir(1)
	else:
		set_dir(0)

	if OS.get_ticks_msec() > next_dir_time:
		dir = next_dir

	#gravity i guess
	if(!is_on_floor()):
		vel.y += 7.5

	vel.x = dir * speed

	if dir == -1:
		animationPlayer.play("walk_left")
	elif dir == 1:
		animationPlayer.play("walk_right")

	vel = move_and_slide(vel, up_direction, false, 4)

	
	

	

