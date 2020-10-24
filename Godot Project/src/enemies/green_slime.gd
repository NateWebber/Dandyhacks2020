extends Enemy

#delay before running at the player
var react_time = 250

#direction handling
var dir = 0
var next_dir = 0
var next_dir_time = 0

#distance from player threshhold before stopping
var offset = 0

func set_dir(target_dir):
	if next_dir != target_dir:
		next_dir = target_dir
		next_dir_time = OS.get_ticks_msec() + react_time

func _ready():
	health = 2
	speed = 25
	damage = 1
	x_kb = 50
	y_kb = 50

func _physics_process(delta):
	vel.x = 0
	if player.position.x < position.x - offset:
		set_dir(-1)
	elif player.position.x > position.x +  offset:
		set_dir(1)
	else:
		set_dir(0)
		
	if OS.get_ticks_msec() > next_dir_time:
		dir = next_dir
		
	if dir == 1:
		vel.x += speed
	if dir == -1:
		vel.x -= speed
		
	#gravity i guess
	vel.y += gravity * delta

	#if dir == -1:
	#	animationPlayer.play("walk_left")
	#elif dir == 1:
	#	animationPlayer.play("walk_right")

	vel = move_and_slide(vel, up_direction)




func _on_Hurtbox_area_entered(area):
	if area.get_parent() == player:
		hit_player()
