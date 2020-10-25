extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var coin_count = 0
var rng = RandomNumberGenerator.new()
const PLATFORM_CHANCE = 0.05


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
	#var current_slice = load("res://terrainGen/floor outside.gd") #first slice should always be ground
	var current_slice = load("res://terrainGen/water fuck.gd")
	var current_height = 0
	
	var generating_platforms = false
	var current_platform_slice
	var platform_height
	var in_cave = false
	var in_temple = false
	var biome_changes = 0
	var previous_biome = "outside"
	var previous_slice = current_slice
	var identical_slice_count = 1	
	print(previous_biome)
	for x in range(1, 150): # iterate over vertical slices
		print(x)
		rng.randomize()
		
		var probability = rng.randi_range(0, 100)
		if(current_slice == load("res://terrainGen/floor outside.gd")):
			# more likely to see downward ramps at high elevations
			if(current_height < -7):
				probability += (-3 * current_height)
			elif(current_height < -10): # make it impossible to go off the top of the map
				probability += (-5 * current_height)
				
		elif(current_slice == load("res://terrainGen/ramp up outside.gd")):
			#if ramping up and the height is getting too much, force flat ground
			if(current_height < -7):
				probability += (-2 * current_height)
				
			elif(current_height < -10):
				current_slice = load("res://terrainGen/floor outside.gd")
				
		elif(current_slice == load("res://terrainGen/ramp down outside.gd")):
			if(current_height > 8):
				current_slice = load("res://terrainGen/floor outside.gd")
			elif(current_height > 0): # decreasingly likely to get downwards ramps as generation moves lower
				probability += (2 * current_height)
			
				
		elif(current_slice == load("res://terrainGen/floor cave.gd")):
			if(current_height < -10) or (current_height > 8): # if we are too high up or low down, don't allow a cave to be generated
				current_slice = load("res://terrainGen/floor outside.gd")
				
		elif(current_slice == load("res://terrainGen/cavern exit jump.gd")):
			if(current_height > 4): # if the cave is too low to jump out of
				print(current_height)
				print("NO JUMP")
				print()
				current_slice = load("res://terrainGen/floor outside 2.gd")
			else:
				print(current_height)
				
		elif(current_slice == load("res://terrainGen/water before drain.gd") or current_slice == load("res://terrainGen/water after drain.gd")):
			if(identical_slice_count >= 2):
				probability = 100
				
		if(current_slice == previous_slice):
			identical_slice_count += 1
		else:
			identical_slice_count = 1
			
		print("CHECKING BIOME CHANGE")
		# check if we changed biomes, increment count, update accordingly
		if(current_slice.biome != previous_biome):
			print("BIOME CHANGE TO " + current_slice.biome)
			biome_changes += 1
			if(current_slice.biome == "cave"):
				in_cave = true
			else:
				in_cave = false
		
		var reference_x = current_slice.reference_x # get the x value on the tilemap from which to copy this slice
		if current_slice.leading_height_change: # if the slice requires a leading height change (such as slope up), execute it
			current_height -= current_slice.delta_height
		
		for y in range(-30, 45): # iterate over all tiles in the slice, copying from the reference position to where we are on the map
			$TileMap.set_cell(x, y + current_height, $TileMap.get_cell(reference_x, y))
		print("tiles set")
		if !current_slice.leading_height_change: # no leading height change so height should be changed now
			current_height -= current_slice.delta_height
		
		if(in_cave):
			for y in range(0, 30):
				$backgroundTileMap.set_cell(x, y, $backgroundTileMap.get_cell(-1, -1))
		
		print("HM...")
		if(current_slice.spawns_enabled == true):
			print("SPAWNS ENABLED")
			var selected = rand_range(0, len(current_slice.spawns_list) - 1)
			var load_string = "res://src/enemies/" + current_slice.spawns_list[selected] + ".gd"
			add_child(load(load_string).instance())
		else:
			print("No spawns at x " + str(x))
			

		previous_biome = current_slice.biome
		previous_slice = current_slice
		var running_total = 0
		# scan through the next possible slices for the ground
		for scan_index in range(0, len(current_slice.weights)):
			running_total += current_slice.weights[scan_index] # keep a running total of the probability numbers
			if(running_total >= probability): # once this total exceeds our random roll, we have chosen the next slice\
				# grab the next slice's script and load it
				if(scan_index > len(current_slice.next_tiles)):
					scan_index = len(current_slice.next_tiles) - 1
				var loadString = "res://terrainGen/" + current_slice.next_tiles[scan_index] + ".gd" 
				current_slice = load(loadString)
				break		
		
		if(!generating_platforms && current_slice.platform_startable):
			if(rng.randf() < PLATFORM_CHANCE):
				generating_platforms = true
				current_platform_slice = load("res://terrainGen/floating platform left.gd")
				platform_height = current_height + 15
		elif(generating_platforms):
			if(current_height + 2 == platform_height):
				if(current_platform_slice != load("res://terrainGen/floating platform left")):
					current_platform_slice = load("res://terrainGen/floating platform right")
			var platform_reference_x = current_platform_slice.reference_x
			$TileMap.set_cell(x, platform_height, $TileMap.get_cell(platform_reference_x, 0))
			
			probability = rng.randi_range(0, 100)
			running_total = 0
			# scan through the next possible slices for the platform
			for scan_index in range(0, len(current_platform_slice.weights)):
				running_total += current_platform_slice.weights[scan_index] # keep a running total of the probability numbers
				if(running_total >= probability): # once this total exceeds our random roll, we have chosen the next platform
					# grab the next platform's script and load it
					if(current_platform_slice.next_tiles[scan_index] == "END"):
						generating_platforms = false
						break
					else:
						var loadString = "res://terrainGen/" + current_platform_slice.next_tiles[scan_index] + ".gd" 
						current_platform_slice = load(loadString)
						break

			
	$TileMap.update_bitmask_region(Vector2(-1, -1), Vector2(1000, 30))


func _on_coin_collected():
	coin_count += 1
	print("yippee")
