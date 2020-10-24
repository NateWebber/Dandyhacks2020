extends KinematicBody2D
class_name Enemy

var health
var damage
var speed
var x_kb
var y_kb

var knocked = false

var vel = Vector2()
var up_direction = Vector2(0, -1)
var gravity = 600

onready var player = get_parent().get_node("Player")

func hit_player():
	print('I hit the player!')
	var dir
	if vel.x < 0:
		dir = -1
	else:
		dir = 1
	player.hit(damage, x_kb, -y_kb, dir)
	

func hit():
	vel.x = 0
	print('I got hit!')
	health -= player.strength
	if health < 1:
		die()
	else:
		knocked = true
		if vel.x < 0:
			vel.x += (speed + player.player_x_kb)
		else:
			vel.x -= (speed + player.player_x_kb)
		vel.y += player.player_y_kb
		vel = move_and_slide(vel, up_direction)
		
func die():
	print('I died!')
	queue_free()
