class_name NeighbourBonus extends TileEffect

@export var points : int
@export var tile_filter : TileFilter


func on_placement(tile : Tile, neighbours : Array[Tile], _grid, game_state : GameState):
	game_state.add_points(tile, neighbours.filter(tile_filter.fits).size() * points)


func on_neighbour_placed(tile : Tile, neighbour : Tile, _other_neighbours : Array[Tile], _grid, game_state : GameState):
	if tile_filter.fits(neighbour):
		game_state.add_points(tile, points)