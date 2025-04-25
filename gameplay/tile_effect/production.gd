class_name Production extends TileEffect

@export var production : int

func on_placement(_tile : Tile, _neighbours : Array[Tile], _grid, game_state : GameState):
	game_state.production += production