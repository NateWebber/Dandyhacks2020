extends Control

#TODO: Add score, timer, and area count(?)
func update_hud(health, score):
	$HealthBar.frame = health
	$coin_count.text = "x " + str(score)
	
func _ready():
	$AnimationPlayer.play("coin")
