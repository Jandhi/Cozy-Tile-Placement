class_name SpawnEffect extends TileEffect

@export var spawn_tile : TileInfo

func on_placement(tile : Tile, _neighbours : Array[Tile], grid : Grid, _game_state : GameState):
	spawn(tile, grid)

func on_season_change(tile : Tile, _neighbours : Array[Tile], grid : Grid, _game_state : GameState):
	spawn(tile, grid)

func spawn(tile : Tile, grid : Grid):
	grid.place_tile(tile.tile_position, spawn_tile)

	