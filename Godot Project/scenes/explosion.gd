extends Node2D

func _ready():
	$AnimationPlayer.play("boom")
	yield($AnimationPlayer, "animation_finished")
	queue_free()
