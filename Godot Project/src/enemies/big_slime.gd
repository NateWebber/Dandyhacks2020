extends Enemy

#animation stuff
onready var animationPlayer = get_node("AnimationPlayer")
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
	health = 10
	speed = 15
	damage = 4
	x_kb = 100
	y_kb = 100
	weight = 3
	coin_value = 15

func _physics_process(delta):
	if !knocked:
		vel.x = 0
		if(abs(get_parent().find_node("Player").position.x - position.x) < 256):
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
	
	if knocked and is_on_floor():
		knocked = false

	if dir == -1:
		animationPlayer.play("left")
	elif dir == 1:
		animationPlayer.play("right")
	else:
		animationPlayer.play("idle")

	vel = move_and_slide(vel, up_direction)




func _on_Hurtbox_area_entered(area):
	if area.get_parent() == player and area.name == "Hitbox":
		hit_player()

