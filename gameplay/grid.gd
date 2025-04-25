class_name Grid extends Node2D

signal preview_moved(tile : Tile)
signal preview_removed()
signal preview_placed(tile : Tile)

@export var width : int
@export var height : int
@export var tile_prototype : PackedScene

var terrain_tiles : Dictionary[Vector2i, Tile] = {}
var building_tiles : Dictionary[Vector2i, Tile] = {}
var denizen_tiles : Dictionary[Vector2i, Tile] = {}
var preview_tile : Tile = null
var drag_start : Vector2 = Vector2.ZERO
var is_dragging : bool = false

static var even_y_neighours = [
	Vector2i(-1, 1),
	Vector2i(-1, -1),
	Vector2i(0, 1),
	Vector2i(0, -1),
	Vector2i(0, 2),
	Vector2i(0, -2),
]

static var odd_x_neighours = [
	Vector2i(1, 1),
	Vector2i(1, -1),
	Vector2i(0, 1),
	Vector2i(0, -1),
	Vector2i(0, 2),
	Vector2i(0, -2),
]

# click and drag
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			drag_start = event.position
			is_dragging = true
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.is_released():
			is_dragging = false
			
	elif event is InputEventMouseMotion:
		if is_dragging:
			self.position += event.position - drag_start
			drag_start = event.position
			
		if preview_tile == null:
			return
		
		var mouse_pos = get_nearest_tile_index(event.position)

		if mouse_pos == preview_tile.tile_position:
			return

		preview_tile.tile_position = mouse_pos 
		preview_tile.position = get_tile_position(preview_tile.tile_position)
		preview_tile.cannot_place.visible = not can_place_preview()
		preview_moved.emit(preview_tile)

var is_selected : bool = false
var grid : Grid = null

func spawn_preview(card : Card):
	var info = card.card_info.tile_info
	preview_tile = tile_prototype.instantiate()
	self.add_child(preview_tile)
	preview_tile.set_tile(info)
	preview_tile.tile_position = get_nearest_tile_index(get_global_mouse_position())
	preview_tile.position = get_tile_position(preview_tile.tile_position)
	preview_tile.cannot_place.visible = not can_place_preview()
	preview_moved.emit(preview_tile)

func remove_preview():
	if preview_tile != null:
		preview_tile.queue_free()
		preview_tile = null
		preview_removed.emit()

func place_preview():
	if preview_tile == null:
		return

	if preview_tile.tile_info.tile_type == TileInfo.Tiletype.TERRAIN:
		terrain_tiles[preview_tile.tile_position] = preview_tile
	elif preview_tile.tile_info.tile_type == TileInfo.Tiletype.BUILDING:
		building_tiles[preview_tile.tile_position] = preview_tile
	elif preview_tile.tile_info.tile_type == TileInfo.Tiletype.DENIZEN:
		denizen_tiles[preview_tile.tile_position] = preview_tile
	
	preview_placed.emit(preview_tile)
	preview_tile = null

func can_place_preview():
	if preview_tile.tile_info.tile_type == TileInfo.Tiletype.TERRAIN:
		return (get_neighbour_indices(preview_tile.tile_position).any(
			func(x): return terrain_tiles.has(x)
		) and not preview_tile.tile_position in terrain_tiles) or terrain_tiles.size() == 0
	if preview_tile.tile_info.tile_type == TileInfo.Tiletype.BUILDING:
		return preview_tile.tile_position in terrain_tiles and preview_tile.tile_position not in building_tiles # and more restrictions after
	if preview_tile.tile_info.tile_type == TileInfo.Tiletype.DENIZEN:
		return preview_tile.tile_position in terrain_tiles and preview_tile.tile_position not in denizen_tiles # and more restrictions after

func get_nearest_tile_index(pos : Vector2) -> Vector2i:
	pos = pos - self.position

	var possible_position = Vector2i(
		int((pos.x + (width / 2.0)) / width), 
		int((pos.y + height) / height)
	)
	var best_distance = (pos - get_tile_position(possible_position)).length()

	for offset in [
		Vector2i(-1, 0), Vector2i(1, 0), Vector2i(0, -1), Vector2i(0, 1), 
		Vector2i(-1, -1), Vector2i(-1, 1), Vector2i(1, -1), Vector2i(1, 1)]:
		var new_position = possible_position + offset
		var new_distance = (pos - get_tile_position(new_position)).length()

		if new_distance < best_distance:
			best_distance = new_distance
			possible_position = new_position

	return possible_position
	

func get_tile_position(index : Vector2i) -> Vector2:
	if index.y % 2 == 0:
		return Vector2(index.x * width, index.y * height)
	else:
		return Vector2(index.x * width + width / 2.0, index.y * height)

func get_neighbour_indices(index : Vector2i) -> Array:
	if index.y % 2 == 0:
		return even_y_neighours.map(func(x): return x + index)
	else:
		return odd_x_neighours.map(func(x): return x + index)

func get_neighbours(index : Vector2i) -> Array[Tile]:
	var result : Array[Tile] = []
	for neighbour in self.get_neighbour_indices(index):
		if terrain_tiles.has(neighbour):
			result.append(terrain_tiles[neighbour])
		elif building_tiles.has(neighbour):
			result.append(building_tiles[neighbour])
		elif denizen_tiles.has(neighbour):
			result.append(denizen_tiles[neighbour])
	return result

func get_all_tiles() -> Array[Tile]:
	var result : Array[Tile] = []
	for tile in terrain_tiles.values():
		result.append(tile)
	for tile in building_tiles.values():
		result.append(tile)
	for tile in denizen_tiles.values():
		result.append(tile)
	return result

func get_surrounding_indices(index : Vector2i, distance : int) -> Array:
	var result = []
	var stack = []
	var visited = { index:  true}

	for neighbour in self.get_neighbour_indices(index):
		stack.append([neighbour, 1])

	while stack.size() > 0:
		var current = stack.pop_front()
		var tile = current[0]
		var my_distance = current[1]

		if my_distance > distance:
			continue

		if visited.has(current):
			continue

		visited[current] = true
		result.append(current)

		for neighbour in self.get_neighbour_indices(tile):
			if neighbour not in visited:
				stack.append([neighbour, my_distance + 1])

	return result

func reset_camera():
	self.position = Vector2.ZERO
