extends KinematicBody2D
class_name Enemy

var health
var damage
var speed
var coin_value
var weight
var x_kb
var y_kb

var knocked = false

var vel = Vector2()
var up_direction = Vector2(0, -1)
var gravity = 600

onready var player = get_parent().get_node("Player")
onready var explosion = preload("res://scenes/explosion.tscn")

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
	var weighted_kb_x = player.player_x_kb / weight
	var weighted_kb_y = player.player_y_kb / weight
	print('I got hit!')
	health -= player.strength
	if health < 1:
		die()
	else:
		knocked = true
		if player.position.x < position.x:
			#print('I should be hit to the right!')
			vel.x += (speed + weighted_kb_x)
			
		else:
			#print('I should be hit to the left!')
			vel.x -= (speed + weighted_kb_x)
			
		vel.y -= weighted_kb_y
		
		vel = move_and_slide(vel, up_direction)
		
func die():
	print('I died!')
	self.visible = false
	var boom = explosion.instance()
	boom.position = self.position
	get_parent().add_child(boom)
	queue_free()
