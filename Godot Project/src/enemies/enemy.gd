extends KinematicBody2D
class_name Enemy

var health
var damage
var speed
var x_kb
var y_kb

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
	print('I got hit!')
	health -= player.strength
	if health < 1:
		die()
	#else:
		
func die():
	print('I died!')
	queue_free()
