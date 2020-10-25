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
	$Area2D/CollisionShape2D.disabled = true
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	velocity = Vector2(rng.randi_range(-50, 50), rng.randi_range(-100, -300))
	$AnimationPlayer.play("coin")
	connect("collected", get_parent(), "coin_collected")
	yield (get_tree().create_timer(1.0), "timeout")
	$Area2D/CollisionShape2D.disabled = false
	$Area2D/CollisionShape2D.disabled = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	velocity.x /= 2
	velocity = move_and_slide(velocity, Vector2.UP)
	



func _on_Area2D_area_entered(area):
	if(player == area.get_parent()):
		emit_signal("collected")
		queue_free()
