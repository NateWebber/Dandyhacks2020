extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var gravity = 600
onready var player = get_parent().get_node("Player")

signal collected()

var velocity
# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/CollisionShape2D.disabled = true
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	velocity = Vector2(rng.randi_range(-150, 150), rng.randi_range(-100, -200))
	$AnimationPlayer.play("coin")
	connect("collected", get_parent(), "coin_collected")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	velocity.x *= (1 - (10 * delta))
	velocity = move_and_slide(velocity, Vector2.UP)
	$Area2D/CollisionShape2D.disabled = !is_on_floor()

func _on_Area2D_area_entered(area):
	if(player == area.get_parent()):
		emit_signal("collected")
		queue_free()
