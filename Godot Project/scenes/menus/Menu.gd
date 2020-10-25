extends Control

onready var transition = $SceneTransitionRect

func _ready():
	$AudioStreamPlayer.play()

func _on_New_Game_pressed():
	transition.transition_to("res://scenes/main.tscn")


func _on_HOF_pressed():
	pass # Replace with function body.
