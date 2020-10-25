extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#cavern with middle platform
const biome = "cave"
const next_tiles = ["cavern 4", "cavern", "cavern 2", "cavern 3"]
const weights = [70, 10, 10, 10]
const reference_x = -70
const delta_height = 0
const leading_height_change = true
const platform_startable = false

const spawns_enabled = true
const spawns_list = ["green_slime", "big_slime"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
