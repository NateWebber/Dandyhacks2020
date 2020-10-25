extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const biome = "cave"
const next_tiles = ["water before drain", "drain before water", "floor cave", "floor cave stalactite", "floor cave pillar", "cavern opening"]
const weights = [1, 2, 45, 45, 4, 3]
const reference_x = -48
const delta_height = 0
const leading_height_change = true
const platform_startable = false

const spawns_enabled = true
const spawns_list = ["green_slime", "blue_slime"]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
