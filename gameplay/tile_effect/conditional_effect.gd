class_name ConditionalEffect extends TileEffect

@export var effects : Array[TileEffect]
@export var conditions : Array[TileConditional]

func on_placement(tile, neighbours : Array[TileInfo], grid, game_state : GameState):
	if conditions.all(func (condition : TileConditional):
		return condition.evaluate(tile, neighbours, grid, game_state
	)):
		for effect in effects:
			effect.on_placement(tile, neighbours, grid, game_state)

func on_turn_end(tile, neighbours : Array[TileInfo], grid, game_state : GameState):
	if conditions.all(func (condition : TileConditional):
		return condition.evaluate(tile, neighbours, grid, game_state
	)):
		for effect in effects:
			effect.on_turn_end(tile, neighbours, grid, game_state)