extends Control

func _ready():
	$AudioStreamPlayer.play()
	
	


func _on_return_pressed():
	$SceneTransitionRect.transition_to("res://scenes/menus/Menu.tscn")
