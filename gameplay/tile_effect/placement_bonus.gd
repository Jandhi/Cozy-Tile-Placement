class_name PlacementBonus extends TileEffect

@export var points : int

func on_placement(tile : Tile, _neighbours : Array[Tile], _grid, game_state : GameState):
	game_state.add_points(tile, points)