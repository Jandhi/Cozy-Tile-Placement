class_name PlacementBonus extends TileEffect

@export var points : int

func on_placement(_tile, _neighbours : Array[TileInfo], _grid, game_state : GameState):
	game_state.points += points