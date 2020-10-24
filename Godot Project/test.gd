extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

	
var rng = RandomNumberGenerator.new()

var current_height = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($Player.position.x > 160):
		$Camera2D.position.x = $Player.position.x
	else:
		$Camera2D.position.x = 160
	

func new_game():
	generate_terrain()

func generate_terrain():
	var current_slice = load("res://terrainGen/floor outside.gd")
	
	for x in range(1, 100):
		rng.randomize()
		var reference_x = current_slice.reference_x # get the x value on the tilemap from which to copy this slice
		if current_slice.leading_height_change: # if the slice requires a leading height change (such as slope up), execute it
			current_height -= current_slice.delta_height
			
		for y in range(-30, 45): # iterate over all tiles in the slice, copying from the reference position to where we are on the map
			$TileMap.set_cell(x, y + current_height, $TileMap.get_cell(reference_x, y))
		
		if !current_slice.leading_height_change: # no leading height change so height should be changed now
			current_height -= current_slice.delta_height
		
		
		
		var probability = rng.randi_range(0, 100)
		if(current_slice == load("./terrainGen/floor outside.gd")):
			# more likely to see downward ramps at high elevations
			if(current_height > 7):
				probability += (3 * current_height)
			elif(current_height > 10): # make it impossible to go off the top of the map
				probability += (5 * current_height)
		elif(current_slice == load("./terrainGen/ramp up outside.gd")):
			#if ramping up and the height is getting too much, force flat ground
			if(current_height > 7):
				probability += (2 * current_height)
		elif(current_slice == load("./terrainGen/ramp down outside.gd")):
			if(current_height < 0): # decreasingly likely to get downwards ramps as generation moves lower
				probability += (-2 * current_height)
		
		
			
		print(probability)
		var running_total = 0
		var probability_scan_index = -1
		for scan_index in range(0, len(current_slice.weights)):
			running_total += current_slice.weights[scan_index]
			if(running_total >= probability):
				var loadString = "./terrainGen/" + current_slice.next_tiles[scan_index] + ".gd"
				current_slice = load(loadString)
				break
		
	
		
		print()	
			
	$TileMap.update_bitmask_region(Vector2(0, 0), Vector2(100, 30))
