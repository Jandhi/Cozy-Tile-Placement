class_name NeighbourCountCondition extends TileConditional

enum ComparisonType {
	Equals,
	GreaterThan,
	LessThan
}

@export var amount : int
@export var comparison_type : ComparisonType 
@export var tile_filter : TileFilter

func evaluate(_tile : Tile, neighbours : Array[Tile], _grid, _game_state : GameState) -> bool:
	var count = neighbours.filter(tile_filter.fits).size()

	match comparison_type:
		ComparisonType.Equals:
			return count == amount
		ComparisonType.GreaterThan:
			return count > amount
		ComparisonType.LessThan:
			return count < amount

	return true
