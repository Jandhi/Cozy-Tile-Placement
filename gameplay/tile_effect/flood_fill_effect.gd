class_name FloodFillEffect extends TileEffect

@export var points : int
@export var tile_filter : TileFilter

func on_placement(tile : Tile, _neighbours : Array[Tile], grid : Grid, game_state : GameState):
	var queue : Array[Vector2i] = [tile.tile_position]
	var visited : Dictionary[Vector2i, bool] = {tile.tile_position : true}
	var count : int = 0

	while queue.size() > 0:
		var current : Vector2i = queue.pop_front()

		var neighbours : Array[Tile] = grid.get_neighbours(current)
		for neighbour in neighbours:
			if visited.has(neighbour.tile_position):
				continue

			visited[neighbour.tile_position] = true

			if not tile_filter.fits(neighbour):
				continue

			count += 1
			queue.append(neighbour.tile_position)
	
	game_state.add_points(tile, count * points)
