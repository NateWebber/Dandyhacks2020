extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const biome = "outside"
const next_tiles = ["ramp up outside", "floor outside"]
const weights = [5, 95]
const reference_x = -35
const delta_height = 1
const leading_height_change = true
const platform_startable = true

const spawns_enabled = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
