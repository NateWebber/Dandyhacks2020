extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

	
var rng = RandomNumberGenerator.new()
var current_slice = load("./terrainGen/floor.gd")
var current_height = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	for x in range(0, 30):
		rng.randomize()
		var reference_x = current_slice.reference_x
		if current_slice.leading_height_change:
			current_height -= current_slice.delta_height
			
		for y in range(0, 24):
			$TileMap.set_cell(x, y + current_height, $TileMap.get_cell(reference_x, y))
		
		if !current_slice.leading_height_change:
			current_height -= current_slice.delta_height
		
		
		
		print("NEW TILE")
		var probability = rng.randi_range(0, 100)
		print(probability)
		var running_total = 0
		var probability_scan_index = -1
		for scan_index in range(0, len(current_slice.weights)):
			running_total += current_slice.weights[scan_index]
			if(running_total >= probability):
				var loadString = "./terrainGen/" + current_slice.next_tiles[scan_index] + ".gd"
				current_slice = load(loadString)
				break
		
	
		print("END NEW TILE")
		print()	
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
