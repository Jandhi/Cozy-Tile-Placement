class_name Tile extends Node2D

@export var is_selected : bool
@export var grid : Grid
var tile_position : Vector2i
var tile_type : TileType = TileType.Volcano
@export var party_particles : PackedScene
@export var floating_points : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

enum TileType {
	Volcano,
	Forest,
	Field,
	Trees,
	Water,
	Hill,
	River,
	Portal,
	Mountain,
	Lake,
	Town,
	Castle,
	Tower,
	Huts,
	Cave,
	Hole,
	DeadTrees,
	Ruin,
	Bones,
	Swamp,
	FloatingIsland,
	Keep,
	Wonder,
	Crystals,
	Stones,
	Farms,
	Fog,
}

var all_tiles = [
	TileType.Volcano,
	TileType.Forest,
	TileType.Field,
	TileType.Trees,
	TileType.Water,
	TileType.Hill,
	TileType.River,
	TileType.Portal,
	TileType.Mountain,
	TileType.Lake,
	TileType.Town,
	TileType.Castle,
	TileType.Tower,
	TileType.Huts,
	TileType.Cave,
	TileType.Hole,
	TileType.DeadTrees,
	TileType.Ruin,
	TileType.Bones,
	TileType.Swamp,
	TileType.FloatingIsland,
	TileType.Keep,
	TileType.Wonder,
	TileType.Crystals,
	TileType.Stones,
	TileType.Farms,
	TileType.Fog,
]

var textures = {
	TileType.Volcano: preload("res://foundation_tiles/greenlands/1-greenlands_vulcano.png"),
	TileType.Forest: preload("res://foundation_tiles/greenlands/2-greenlands_forest.png"),
	TileType.Field: preload("res://foundation_tiles/greenlands/3-greenlands_tundra.png"),
	TileType.Trees: preload("res://foundation_tiles/greenlands/4-greenlands_trees.png"),
	TileType.Water: preload("res://foundation_tiles/greenlands/5-greenlands_water.png"),
	TileType.Hill: preload("res://foundation_tiles/greenlands/6-greenlands_hills.png"),
	TileType.River: preload("res://foundation_tiles/greenlands/7-greenlands_river.png"),
	TileType.Portal: preload("res://foundation_tiles/greenlands/8-greenlands_portal.png"),
	TileType.Mountain: preload("res://foundation_tiles/greenlands/9-greenlands_mountains.png"),
	TileType.Lake: preload("res://foundation_tiles/greenlands/10-greenlands_lake.png"),
	TileType.Town: preload("res://foundation_tiles/greenlands/11-greenlands_village.png"),
	TileType.Castle: preload("res://foundation_tiles/greenlands/12-greenlands_city.png"),
	TileType.Tower: preload("res://foundation_tiles/greenlands/13-greenlands_tower.png"),
	TileType.Huts: preload("res://foundation_tiles/greenlands/14-greenlands_community.png"),
	TileType.Cave: preload("res://foundation_tiles/greenlands/15-greenlands_cave.png"),
	TileType.Hole: preload("res://foundation_tiles/greenlands/16-greenlands_hole.png"),
	TileType.DeadTrees: preload("res://foundation_tiles/greenlands/17-greenlands_dead-Trees.png"),
	TileType.Ruin: preload("res://foundation_tiles/greenlands/18-greenlands_ruins.png"),
	TileType.Bones: preload("res://foundation_tiles/greenlands/19-greenlands_graveyard.png"),
	TileType.Swamp: preload("res://foundation_tiles/greenlands/20-greenlands_swamp.png"),
	TileType.FloatingIsland: preload("res://foundation_tiles/greenlands/floating_sland.png"),
	TileType.Keep: preload("res://foundation_tiles/greenlands/22-greenlands_keep.png"),
	TileType.Wonder: preload("res://foundation_tiles/greenlands/23-greenlands_wonder.png"),
	TileType.Crystals: preload("res://foundation_tiles/greenlands/24-greenlands_cristals.png"),
	TileType.Stones: preload("res://foundation_tiles/greenlands/25-greenlands_stones.png"),
	TileType.Farms: preload("res://foundation_tiles/greenlands/26-greenlands_farms.png"),
	TileType.Fog: preload("res://foundation_tiles/greenlands/27-greenlands_fog.png"),
}

# names
var names = {
	TileType.Volcano: "Volcano",
	TileType.Forest: "Forest",
	TileType.Field: "Field",
	TileType.Trees: "Trees",
	TileType.Water: "Water",
	TileType.Hill: "Hill",
	TileType.River: "River",
	TileType.Portal: "Portal",
	TileType.Mountain: "Mountain",
	TileType.Lake: "Lake",
	TileType.Town: "Town",
	TileType.Castle: "Castle",
	TileType.Tower: "Tower",
	TileType.Huts: "Hut",
	TileType.Cave: "Cave",
	TileType.Hole: "Hole",
	TileType.DeadTrees: "Dead Trees",
	TileType.Ruin: "Ruin",
	TileType.Bones: "Bones",
	TileType.Swamp: "Swamp",
	TileType.FloatingIsland: "Floating Island",
	TileType.Keep: "Keep",
	TileType.Wonder: "Wonder",
	TileType.Crystals: "Crystals",
	TileType.Stones: "Stones",
	TileType.Farms: "Farms",
	TileType.Fog: "Fog",
}

var descriptions = {
	TileType.Volcano: "[color=green]+50[/color]\n[color=red]-20[/color] for each neighbouring [color=yellow]Town[/color], [color=yellow]Castle[/color], [color=yellow]Huts[/color], [color=yellow]Forest[/color], [color=yellow]Wonder[/color], or [color=yellow]Farms[/color].",
	TileType.Forest: "[color=green]+15[/color] for each neighbouring [color=yellow]Forest[/color].\n[color=green]+5[/color] for each neighbouring [color=yellow]Trees[/color]. \n[color=red]-10[/color] for each neighbouring [color=yellow]Town[/color]",
	TileType.Field: "[color=green]+10[/color] for each neighbouring [color=yellow]Field[/color], [color=yellow]Hill[/color], [color=yellow]Swamp[/color], or [color=yellow]Trees[/color].",
	TileType.Trees: "[color=green]+10[/color] points. If next to two [color=yellow]Forests[/color], [color=green]+20[/color] points and becomes a [color=yellow]Forest[/color].",
	TileType.Water: "[color=green]+15[/color] for each neighbouring [color=yellow]Water[/color]", 
	TileType.Hill: "[color=green]+10[/color] for each neighbouring [color=yellow]Field[/color], [color=yellow]Mountain[/color], or [color=yellow]Volcano[/color].",
	TileType.River: "[color=green]+20[/color] if next to exactly one other [color=yellow]River[/color], [color=yellow]Water[/color], or [color=yellow]Lake[/color].",
	TileType.Portal: "[color=green]+25[/color]\n Randomly changes the type of neighbouring all_tiles.",
	TileType.Mountain: "[color=green]+10[/color] for each neighbouring [color=yellow]Mountain[/color], [color=yellow]Hill[/color], or [color=yellow]Volcano[/color].",
	TileType.Lake: "[color=green]+20[/color] points",
	TileType.Town: "[color=green]+25[/color]\n[color=red]-10[/color] for each neighbouring [color=yellow]Town[/color]. \n[color=red]-20[/color] for each neighbouring [color=yellow]Forest[/color], [color=yellow]Hill[/color], [color=yellow]Mountain[/color], or [color=yellow]Swamp[/color].",
	TileType.Castle: "[color=green]+20[/color] for each neighbouring [color=yellow]Town[/color]\n[color=red]-50[/color] for each neighbouring [color=yellow]Castle[/color].",
	TileType.Tower: "[color=green]+10[/color] for each neighbouring unexplored tile.",
	TileType.Huts: "Three huts will turn into towns and give [color=green]+20[/color] points each.",
	TileType.Cave: "[color=green]+15[/color] for each neighbouring [color=yellow]Mountain], [color=yellow]Hill[/color], or [color=yellow]Bones[/color].",
	TileType.Hole: "[color=green]+10[/color] for each neighbouring [color=yellow]Water[/color], [color=yellow]River[/color], or [color=yellow]Lake[/color], turning them into [color=yellow]Field[/color] or [color=yellow]Swamp[/color] at random.",
	TileType.DeadTrees: "[color=green]+15[/color] when next to [color=yellow]Water[/color], a [color=yellow]River[/color] or [color=yellow]Lake[/color], turning into [color=yellow]Trees[/color].",
	TileType.Ruin: "[color=green]+10[/color] for each neighbouring [color=yellow]Field[/color], [color=yellow]Fog[/color], [color=yellow]Bones[/color] or [color=yellow]Swamp[/color].",
	TileType.Bones: "[color=green]+15[/color] for each neighbouring [color=yellow]Swamp[/color] or [color=yellow]Cave[/color].",
	TileType.Swamp: "[color=green]+10[/color] points\n[color=green]+10[/color] for each neighbouring [color=yellow]Swamp[/color].",
	TileType.FloatingIsland: "[color=green]+20[/color]\n Can be placed anywhere.",
	TileType.Keep: "[color=green]+25[/color]\n[color=red]-10[/color] for each neighbouring [color=yellow]Cave[/color], [color=yellow]Bones[/color], [color=yellow]Hole[/color], or [color=yellow]Crystals[/color].",
	TileType.Wonder: "[color=green]+50[/color] if it has exactly three neighbours.",
	TileType.Crystals: "[color=green]+50[/color] once fully surrounded",
	TileType.Stones: "[color=green]+10[/color] for each adjacent [color=yellow]Mountain[/color], [color=yellow]Hill[/color], [color=yellow]Forest[/color], [color=yellow]Wonder[/color], or [color=yellow]River[/color].",
	TileType.Farms: "[color=green]+15[/color]\nIf next to a [color=yellow]Field[/color], [color=green]+15[/color] and turn it into [color=yellow]Farms[/color].",
	TileType.Fog: "[color=green]+5[/color] for each neighbour.\nCan be placed anywhere.",
}

func set_type(type : TileType):
	tile_type = type
	$Sprite2D.texture = textures[type]

func get_tile_name() -> String:
	return names[tile_type]

func get_tile_description() -> String:
	return descriptions[tile_type]

func get_tile_texture() -> Texture:
	return textures[tile_type]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):

	if not is_selected or grid.is_menu_open:
		return

	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if can_place():
				grid.add_tile_to_position(tile_position, self)

	elif event is InputEventMouseMotion:

		if grid == null:
			return


		var mouse_pos = grid.get_nearest_tile_index(event.position)

		if mouse_pos == tile_position:
			return

		grid.tic_sound.play()

		tile_position = mouse_pos 
		self.position = grid.get_tile_position(tile_position)
		grid.position_debug.text = str(tile_position)

		if can_place():
			self.modulate = Color(1, 1, 1, 1)
			grid.update_tile_bonus(calculate_score())
		else:
			self.modulate = Color(1, 0, 0, 1)
			grid.update_tile_bonus(0)

func can_place() -> bool:
	var has_neighbour = grid.get_neighbour_indices(tile_position).any(func(x): 	
		return grid.tiles.has(x)
	)

	var location_is_free = (self.tile_type in [TileType.FloatingIsland, TileType.Fog]) or not grid.tiles.has(tile_position)

	return location_is_free and (grid.tiles.size() == 0 or has_neighbour)

func calculate_score() -> int:
	return flat_bonus() + calculate_adjacency_bonus() + special_bonus() + neighbours_bonus()

func calculate_adjacency_bonus() -> int:
	var bonus = 0
	var neighbours = grid.get_neighbour_indices(tile_position)
	for neighbour in neighbours:
		if grid.tiles.has(neighbour):
			var neighbour_type = grid.tiles[neighbour].tile_type
			var bonuses = self.adjacency_bonuses()

			if neighbour_type in bonuses:
				bonus += bonuses[neighbour_type]

	return bonus

func on_place():
	var calculated_special_bonus = special_bonus()

	for neighbour in grid.get_neighbour_indices(tile_position):
		if grid.tiles.has(neighbour):
			grid.tiles[neighbour].on_neighbour_placed()

	match tile_type:
		TileType.Trees:
			if calculated_special_bonus > 0:
				play_effect()
				self.set_type(TileType.Forest)

		TileType.Huts:
			if calculated_special_bonus > 0:
				play_effect()
				self.set_type(TileType.Town)

				for neighbour in grid.get_neighbour_indices(tile_position):
					if grid.tiles.has(neighbour) and grid.tiles[neighbour].tile_type == TileType.Huts:
						grid.tiles[neighbour].set_type(TileType.Town)
						grid.tiles[neighbour].play_effect()

		TileType.DeadTrees:
			if calculated_special_bonus > 0:
				play_effect()
				self.set_type(TileType.Trees)

		TileType.Farms:
			if calculated_special_bonus > 0:
				var eligible_neighbours = grid.get_neighbour_indices(tile_position).filter(func(x): 
					return grid.tiles.has(x) and grid.tiles[x].tile_type == TileType.Field
				)

				var neighbour = eligible_neighbours.pick_random()
				if neighbour:
					grid.tiles[neighbour].set_type(TileType.Farms)
					grid.tiles[neighbour].play_effect()

		TileType.Hole:
			var eligible_neighbours = grid.get_neighbour_indices(tile_position).filter(func(x): 
				return grid.tiles.has(x) and grid.tiles[x].tile_type in [TileType.Water, TileType.River, TileType.Lake]
			)

			for neighbour in eligible_neighbours:
				grid.tiles[neighbour].set_type([TileType.Field, TileType.Swamp].pick_random())
				grid.tiles[neighbour].play_effect()

		TileType.Portal:
			var eligible_neighbours = grid.get_neighbour_indices(tile_position).filter(func(x): 
				return grid.tiles.has(x)
			)

			for neighbour in eligible_neighbours:
				grid.tiles[neighbour].set_type(all_tiles.pick_random())
				grid.tiles[neighbour].play_effect()

		_:
			pass

func on_neighbour_placed():
	match tile_type:
		TileType.Trees:
			if special_bonus() > 0:
				play_effect()
				self.set_type(TileType.Forest)
		
		TileType.DeadTrees:
			if special_bonus() > 0:
				play_effect()
				self.set_type(TileType.Trees)

		_:
			pass

func neighbours_bonus() -> int:
	var sum = 0

	for neighbour in grid.get_neighbour_indices(tile_position):
		if grid.tiles.has(neighbour):
			sum += grid.tiles[neighbour].calc_neighbour_placement_bonus(self.tile_type, tile_position)

	return sum

func play_effect():
	grid.combo_sound.play()
	var particles : CPUParticles2D = party_particles.instantiate()
	add_child(particles)
	particles.position = Vector2(0, 0)
	particles.emitting = true
	particles.one_shot = true

	await get_tree().create_timer(2.0).timeout
	particles.queue_free()

func calc_neighbour_placement_bonus(new_neighbour : TileType, placement_pos : Vector2i) -> int:
	match self.tile_type:
		TileType.Trees:
			if new_neighbour != TileType.Forest:
				return 0
			
			var neighbours = grid.get_neighbour_indices(tile_position)
			var count = 0
			for neighbour in neighbours:
				if grid.tiles.has(neighbour) and grid.tiles[neighbour].tile_type == TileType.Forest:
					count += 1

			if count >= 1:
				return 20
			else:
				return 0

		TileType.Crystals:
			var tiles = grid.get_surrounding_indices(tile_position, 1)
			var count = 0

			for tile in tiles:
				if grid.tiles.has(tile):
					count += 1

			if count == 6:
				return 50
			else:
				return 0
		_:
			return 0

func special_bonus() -> int:
	match self.tile_type:
		TileType.Trees:
			var neighbours = grid.get_neighbour_indices(tile_position)
			var count = 0
			for neighbour in neighbours:
				if grid.tiles.has(neighbour) and grid.tiles[neighbour].tile_type == TileType.Forest:
					count += 1

			if count >= 2:
				return 20
			else:
				return 0
		TileType.Tower:
			var neighbours = grid.get_neighbour_indices(tile_position)
			var count = 0
			for neighbour in neighbours:
				if not grid.tiles.has(neighbour):
					count += 1

			return count * 10

		TileType.Crystals:
			var tiles = grid.get_surrounding_indices(tile_position, 1)
			var count = 0

			for tile in tiles:
				if grid.tiles.has(tile):
					count += 1

			if count == 6:
				return 50
			else:
				return 0

		TileType.River:
			var neighbours = grid.get_neighbour_indices(tile_position)
			var count = 0
			for neighbour in neighbours:
				if grid.tiles.has(neighbour) and (grid.tiles[neighbour].tile_type in [TileType.River, TileType.Lake, TileType.Water]):
					count += 1

			if count == 1:
				return 20
			else:
				return 0

		TileType.DeadTrees:
			var neighbours = grid.get_neighbour_indices(tile_position)
			var count = 0
			for neighbour in neighbours:
				if grid.tiles.has(neighbour) and (grid.tiles[neighbour].tile_type in [TileType.River, TileType.Lake, TileType.Water]):
					count += 1

			if count >= 1:
				return 15
			else:
				return 0

		TileType.Huts:
			var neighbours = grid.get_neighbour_indices(tile_position)
			var count = 0
			for neighbour in neighbours:
				if grid.tiles.has(neighbour) and grid.tiles[neighbour].tile_type == TileType.Huts:
					count += 1

			if count >= 2:
				return 20 * count
			else:
				return 0

		TileType.Farms:
			var neighbours = grid.get_neighbour_indices(tile_position)
			var count = 0
			for neighbour in neighbours:
				if grid.tiles.has(neighbour) and grid.tiles[neighbour].tile_type == TileType.Field:
					count += 1

			if count >= 1:
				return 15
			else:
				return 0

		TileType.Wonder:
			var neighbours = grid.get_neighbour_indices(tile_position)
			var count = 0
			for neighbour in neighbours:
				if grid.tiles.has(neighbour):
					count += 1

			if count == 3:
				return 50
			else:
				return 0


		TileType.Fog:
			var neighbours = grid.get_neighbour_indices(tile_position)
			var count = 0
			for neighbour in neighbours:
				if grid.tiles.has(neighbour):
					count += 1

			return count * 5

		_:
			return 0

func adjacency_bonuses() -> Dictionary:
	match self.tile_type:
		TileType.Forest:
			return {
				TileType.Forest: 10,
				TileType.Trees: 5,
				TileType.Town: -10,
			}
		TileType.Volcano:
			return {
				TileType.Town: -20,
				TileType.Castle: -20,
				TileType.Huts: -20,
				TileType.Forest: -20,
				TileType.Wonder: -20,
				TileType.Farms: -20,
			}
		TileType.Field:
			return {
				TileType.Field: 10,
				TileType.Hill: 10,
				TileType.Swamp: 10,
				TileType.Trees: 10,
			}
		TileType.Water:
			return {
				TileType.Water: 15,
			}
		TileType.Mountain:
			return {
				TileType.Mountain: 10,
				TileType.Hill: 10,
				TileType.Volcano: 10,
			}
		TileType.Hill:
			return {
				TileType.Field: 10,
				TileType.Mountain: 10,
				TileType.Volcano: 10,
			}
		TileType.Town:
			return {
				TileType.Town: -10,
				TileType.Forest: -20,
				TileType.Hill: -20,
				TileType.Mountain: -20,
				TileType.Swamp: -20,
			}
		TileType.Castle:
			return {
				TileType.Town: 20,
				TileType.Castle: -50,
			}
		TileType.Hole:
			return {
				TileType.Water: 10,
				TileType.River: 10,
				TileType.Lake: 10,
			}
		TileType.Cave:
			return {
				TileType.Mountain: 15,
				TileType.Hill: 15,
				TileType.Bones: 15,
			}
		TileType.Bones:
			return {
				TileType.Swamp: 15,
				TileType.Cave: 15,
			}
		TileType.Stones:
			return {
				TileType.Mountain: 10,
				TileType.Hill: 10,
				TileType.Forest: 10,
				TileType.Wonder: 10,
				TileType.River: 10,
			}
		TileType.Ruin:
			return {
				TileType.Field: 10,
				TileType.Fog: 10,
				TileType.Bones: 10,
				TileType.Swamp: 10,
			}
		TileType.Keep:
			return {
				TileType.Cave: -10,
				TileType.Bones: -10,
				TileType.Hole: -10,
				TileType.Crystals: -10,
			}
		TileType.Swamp:
			return {
				TileType.Swamp: 10,
			}
		_:
			return {}

func flat_bonus() -> int:
	match self.tile_type:
		TileType.Trees:
			return 10
		TileType.Town:
			return 25
		TileType.Farms:
			return 15
		TileType.Lake:
			return 20
		TileType.FloatingIsland:
			return 20
		TileType.Swamp:
			return 10
		TileType.Keep:
			return 25
		TileType.Volcano:
			return 50
		TileType.Portal:
			return 25
		_:
			return 0
