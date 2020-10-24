extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

	
var rng = RandomNumberGenerator.new()
const PLATFORM_CHANCE = 0.99


# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.set_target_fps(Engine.get_iterations_per_second())
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($Player.position.x > 160):
		$Sprite.position.x = $Player.position.x
		$Camera2D.position.x = $Player.position.x
	else:
		$Sprite.position.x = $Player.position.x
		$Camera2D.position.x = 160
	

func new_game():
	generate_terrain()

func generate_terrain():
	var current_slice = load("res://terrainGen/floor outside.gd") #first slice should always be ground
	var current_height = 0
	
	var generating_platforms = false
	var current_platform_slice
	var platform_height
	
	
	for x in range(1, 100): # iterate over vertical slices
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
		
		var running_total = 0
		var probability_scan_index = -1
		# scan through the next possible slices for the ground
		for scan_index in range(0, len(current_slice.weights)):
			running_total += current_slice.weights[scan_index] # keep a running total of the probability numbers
			if(running_total >= probability): # once this total exceeds our random roll, we have chosen the next slice\
				# grab the next slice's script and load it
				var loadString = "./terrainGen/" + current_slice.next_tiles[scan_index] + ".gd" 
				current_slice = load(loadString)
				break
		
		
		
		if(!generating_platforms && current_slice.platform_startable):
			if(rng.randf() < PLATFORM_CHANCE):
				generating_platforms = true
				current_platform_slice = load("./terrainGen/floating platform left.gd")
				platform_height = current_height + 15
		elif(generating_platforms):
			if(current_height + 2 == platform_height):
				if(current_platform_slice != load("./terrainGen/floating platform left")):
					current_platform_slice = load("./terrainGen/floating platform right")
			var platform_reference_x = current_platform_slice.reference_x
			$TileMap.set_cell(x, platform_height, $TileMap.get_cell(platform_reference_x, 0))
			
			probability = rng.randi_range(0, 100)
			running_total = 0
			probability_scan_index = -1
			# scan through the next possible slices for the platform
			for scan_index in range(0, len(current_platform_slice.weights)):
				running_total += current_platform_slice.weights[scan_index] # keep a running total of the probability numbers
				if(running_total >= probability): # once this total exceeds our random roll, we have chosen the next platform
					# grab the next platform's script and load it
					if(current_platform_slice.next_tiles[scan_index] == "END"):
						generating_platforms = false
					var loadString = "./terrainGen/" + current_platform_slice.next_tiles[scan_index] + ".gd" 
					current_platform_slice = load(loadString)
					break
			
			
		
	
		
		print()	
			
	$TileMap.update_bitmask_region(Vector2(0, 0), Vector2(100, 30))
