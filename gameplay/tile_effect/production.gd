class_name Production extends TileEffect

@export var production : int

func on_placement(_tile, _neighbours : Array[TileInfo], _grid, game_state : GameState):
	game_state.production += production