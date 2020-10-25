extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const biome = "outside"
const next_tiles = ["ramp up outside", "floor outside", "ramp down outside"]
const weights = [13, 75, 12]
const reference_x = -33
const delta_height = 0
const leading_height_change = false
const platform_startable = true

const spawns_enabled = true
const spawns_list = ["green_slime", "blue_slime", "blue_slime"]



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
