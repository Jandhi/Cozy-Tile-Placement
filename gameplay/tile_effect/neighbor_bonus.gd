class_name NeighbourBonus extends TileEffect

@export var points : int
@export var required_name : String
@export var required_tags : Array[Tags.Tag]
@export var required_absent_tags : Array[Tags.Tag]

func on_placement(_tile, neighbours : Array[TileInfo], _grid, game_state : GameState):
	game_state.points += neighbours.filter(self.fits).size() * points

func fits(neighbour : TileInfo):
	return required_tags.all(func (tag : Tags.Tag):
		return neighbour.tags.has(tag)
	) and required_absent_tags.all(func (tag : Tags.Tag):
		return not neighbour.tags.has(tag)
	) and (required_name == "" or required_name == neighbour.tile_name)

func on_neighbour_placed(_tile, neighbour : TileInfo, _other_neighbours : Array[TileInfo], _grid, game_state : GameState):
	if self.fits(neighbour):
		game_state.points += points