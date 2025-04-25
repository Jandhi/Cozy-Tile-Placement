class_name TileEffect extends Resource

func on_placement(_tile : Tile, _neighbours : Array[Tile], _grid, _game_state : GameState):
	pass

func on_turn_end(_tile : Tile, _neighbours : Array[Tile], _grid, _game_state : GameState):
	pass

func on_neighbour_placed(_tile : Tile, _neighbour : Tile, _other_neighbours : Array[Tile], _grid, _game_state : GameState):
	pass