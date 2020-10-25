extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#cavern with stalactite
const biome = "cave"
const next_tiles = ["cavern", "cavern 4", "cavern close"]
const weights = [85, 10, 5]
const reference_x = -68
const delta_height = 0
const leading_height_change = true
const platform_startable = false

const spawns_enabled = true
const spawns_list = ["green_slime"]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
