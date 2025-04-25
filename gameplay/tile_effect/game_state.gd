class_name GameState extends Resource

var points : int
var production : int
var gold : int
var days : int
var is_daytime : bool

var point_changes : Dictionary[Tile, int] = {}

func add_points(tile : Tile, change : int):
	if point_changes.has(tile):
		point_changes[tile] += change
	else:
		point_changes[tile] = change	

	points += change