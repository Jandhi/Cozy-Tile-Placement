class_name GameManager extends Node

@export var grid : Grid
@export var deck_manager : DeckManager
@export var game_state : GameState
@export var season : Season
@export var floating_points_prefab : PackedScene

var season_length : int = 10
var threshold : int = 100

@export_group("UI Elements")
@export var season_display : SeasonDisplay
@export var background : ColorRect

func _ready():
	game_state.is_daytime = true

	grid.preview_moved.connect(func(prev : Tile):
		if prev.cannot_place.visible:
			season_display.set_progress(game_state.points, threshold)
			return

		var game_state_clone = clone_game_state()
		score_tile(prev, game_state_clone)
		season_display.set_progress_preview(game_state.points, game_state_clone.points, threshold)
	)
	grid.preview_removed.connect(func():
		season_display.set_progress(game_state.points, threshold)
	)
	grid.tile_placed.connect(func(prev : Tile):
		var game_state_clone = clone_game_state()
		score_tile(prev, game_state_clone)
		season_display.set_progress(game_state_clone.points, threshold)

		for tile in game_state_clone.point_changes.keys():
			spawn_floating_points(tile, game_state_clone.point_changes[tile])

		game_state.points = game_state_clone.points
		game_state.production = game_state_clone.production
		game_state.gold = game_state_clone.gold
	)

func start_game(starting_deck : StartingDeck):
	var id_counter = 0
	var cards : Array[CardInfo] = []
	for tile_info in starting_deck.get_cards():
		var card_info : CardInfo = CardInfo.new()
		card_info.id = id_counter
		id_counter += 1
		card_info.type = CardInfo.CardType.TILE
		card_info.tile_info = tile_info
		cards.append(card_info)

	deck_manager.set_deck(cards)
	set_season(season)
	await deck_manager.draw_hand(5)

func set_season(new_season : Season):
	season_display.set_season(new_season.season_name, threshold, new_season.effect_description, 10)
	background.color = new_season.day_color if game_state.is_daytime else new_season.night_color

	var game_state_clone = clone_game_state()

	for tile in grid.get_all_tiles():
		for effect in tile.tile_info.tile_effects:
			effect.on_season_change(tile, grid.get_neighbours(tile.tile_position), grid, game_state_clone)

	for tile in game_state.point_changes.keys():
		spawn_floating_points(tile, game_state.point_changes[tile])
	game_state.point_changes.clear()

func spawn_floating_points(tile : Tile, points : int):
	var floating_points = floating_points_prefab.instantiate()
	floating_points.set_text(points)
	grid.add_child(floating_points)	
	floating_points.position = grid.get_tile_position(tile.tile_position)
	floating_points.start_fade()

func score_tile(tile : Tile, scored_game_state : GameState):
	for effect in tile.tile_info.tile_effects:
		effect.on_placement(tile, grid.get_neighbours(tile.tile_position), grid, scored_game_state)

	for neighbour in grid.get_neighbours(tile.tile_position):
		for effect in neighbour.tile_info.tile_effects:
			effect.on_neighbour_placed(neighbour, tile, grid.get_neighbours(neighbour.tile_position), grid, scored_game_state)

func end_turn():
	print("End turn")

	await deck_manager.discard_hand()

	for tile in grid.get_all_tiles():
		for effect in tile.tile_info.tile_effects:
			effect.on_turn_end(tile, grid.get_neighbours(tile.tile_position), grid, game_state)
	
	season_display.set_progress(game_state.points, threshold)

	for tile in game_state.point_changes.keys():
		spawn_floating_points(tile, game_state.point_changes[tile])
	game_state.point_changes.clear()

	var tween = get_tree().create_tween()
	tween.tween_property(background, "color", season.night_color if game_state.is_daytime else season.day_color, 0.5)

	game_state.days += 1
	game_state.is_daytime = not game_state.is_daytime
	season_display.set_days_left(season_length - game_state.days)

	await deck_manager.draw_hand(5)

func clone_game_state() -> GameState:
	var state = GameState.new()
	state.points = game_state.points
	state.production = game_state.production
	state.gold = game_state.gold
	state.days = game_state.days
	state.is_daytime = game_state.is_daytime
	return state
