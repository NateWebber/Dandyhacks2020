extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const biome = "cave"
const next_tiles = ["water before drain", "floor cave", "drain after water"]
const weights = [50, 10, 40]
const reference_x = -52
const delta_height = 0
const leading_height_change = true
const platform_startable = false

const spawns_enabled = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
