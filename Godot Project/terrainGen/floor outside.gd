extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const next_tiles = ["ramp up outside", "floor outside", "ramp down outside"]
const weights = [13, 75, 12]
const reference_x = -32
const delta_height = 0
const leading_height_change = false
const platform_start_chance = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
