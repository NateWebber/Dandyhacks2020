extends KinematicBody2D

#Find the player 
onready var Player = get_parent().get_node("Player")

var vel = Vector2(0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

    if Player.position.x < position.x:
        vel.x = -100
    elif Player.position.x > position.x:
        vel.x = 100
    else:
        vel.x = 0

    #gravity i guess
    if(!is_on_floor()):
        vel.y += 7.5

    
    

	

