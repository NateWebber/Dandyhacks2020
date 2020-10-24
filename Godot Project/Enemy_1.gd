extends KinematicBody2D

#Find the player 
onready var Player = get_parent().get_node("Player")

var vel = Vector2(0, 0)
var up_direction = Vector2(0, -1)

#delay before running at the player
var react_time = 400


var dir = 0
var next_dir = 0
var next_dir_time = 0

#func _ready():
    #$CollisionShape2D.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

    if Player.position.x < position.x and next_dir != -1:
        next_dir = -1
        next_dir_time = OS.get_ticks_msec() + react_time
    elif Player.position.x > position.x and next_dir != 1:
        next_dir = 1
        next_dir_time = OS.get_ticks_msec() + react_time
    elif Player.position.x == position.x and next_dir != 0:
        next_dir = 0
        next_dir_time = OS.get_ticks_msec() + react_time

    if OS.get_ticks_msec() > next_dir_time:
        dir = next_dir

    #gravity i guess
    if(!is_on_floor()):
        vel.y += 7.5

    vel.x = dir * 100

    vel = move_and_slide(vel, up_direction, false, 4)

    
    

	

