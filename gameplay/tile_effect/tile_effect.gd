class_name TileEffect extends Resource

func on_placement(_tile, _neighbours : Array[TileInfo], _grid, _game_state : GameState):
	pass

func on_turn_end(_tile, _neighbours : Array[TileInfo], _grid, _game_state : GameState):
	pass

func on_neighbour_placed(_tile, _neighbour : TileInfo, _other_neighbours : Array[TileInfo], _grid, _game_state : GameState):
	pass