extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
var up_direction = Vector2(0, -1)
var jumping = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	velocity = velocity.move_toward(input_vector * 100, 3)
	
	if(Input.get_action_strength("ui_up") > 0) && !jumping:
		velocity.y -= 200
		jumping = true
	
	if(!is_on_floor()):
		velocity.y += 5
		
	
	
	velocity = move_and_slide(velocity, up_direction, false, 4)#PI/3.9)
	
	if(velocity.y == 0):
		jumping = false
