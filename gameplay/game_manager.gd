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
	grid.preview_placed.connect(func(prev : Tile):
		var game_state_clone = clone_game_state()
		score_tile(prev, game_state_clone)
		season_display.set_progress(game_state_clone.points, threshold)

		for tile in game_state_clone.point_changes.keys():
			spawn_floating_points(tile, game_state_clone.point_changes[tile])

		game_state.points = game_state_clone.points
		game_state.production = game_state_clone.production
		game_state.gold = game_state_clone.gold
	)

func start_game():
	await deck_manager.draw_hand(5)
	set_season(season)

func set_season(season : Season):
	season_display.set_season(season.season_name, threshold, season.effect_description, 10)
	background.color = season.day_color if game_state.is_daytime else season.night_color

func spawn_floating_points(tile : Tile, points : int):
	var floating_points = floating_points_prefab.instantiate()
	floating_points.set_text(points)
	grid.add_child(floating_points)	
	floating_points.position = grid.get_tile_position(tile.tile_position)
	floating_points.start_fade()

func score_tile(tile : Tile, scored_game_state : GameState):
	for effect in tile.tile_info.tile_effects:
		effect.on_placement(tile, grid.get_neighbours(tile.position), grid, scored_game_state)

	for neighbour in grid.get_neighbours(tile.position):
		for effect in neighbour.tile_info.tile_effects:
			effect.on_neighbour_placed(neighbour, tile, grid.get_neighbours(neighbour.position), grid, scored_game_state)

func end_turn():
	print("End turn")

	await deck_manager.discard_hand()

	var game_state_clone = clone_game_state()

	for tile in grid.get_all_tiles():
		for effect in tile.tile_info.tile_effects:
			effect.on_turn_end(tile, grid.get_neighbours(tile.position), grid, game_state)
	
	season_display.set_progress(game_state.points, threshold)

	for tile in game_state_clone.point_changes.keys():
		spawn_floating_points(tile, game_state_clone.point_changes[tile])

	var tween = get_tree().create_tween()
	tween.tween_property(background, "color", season.night_color if game_state.is_daytime else season.day_color, 0.5)

	game_state.points = game_state_clone.points
	game_state.production = game_state_clone.production
	game_state.gold = game_state_clone.gold

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
