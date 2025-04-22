class_name NeighbourCountCondition extends TileConditional

enum ComparisonType {
	Equals,
	GreaterThan,
	LessThan
}

@export var amount : int
@export var comparison_type : ComparisonType 
@export var required_tags : Array[Tags.Tag]
@export var required_absent_tags : Array[Tags.Tag]

func evaluate(_tile, neighbours : Array[TileInfo], _grid, _game_state : GameState) -> bool:
	var count = neighbours.filter(self.fits).size()
	
	match comparison_type:
		ComparisonType.Equals:
			return count == amount
		ComparisonType.GreaterThan:
			return count > amount
		ComparisonType.LessThan:
			return count < amount

	return true


func fits(neighbour : TileInfo):
	return required_tags.all(func(tag : Tags.Tag):
		return neighbour.tags.has(tag)
	) and required_absent_tags.all(func (tag : Tags.Tag):
		return not neighbour.tags.has(tag)
	)
