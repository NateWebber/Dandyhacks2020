extends ColorRect

onready var animPlayer = $AnimationPlayer

func _ready():
	animPlayer.play_backwards("Fade")
	
func transition_to(next_scene):
	animPlayer.play("Fade")
	yield(animPlayer, "animation_finished")
	get_tree().change_scene(next_scene)
	
