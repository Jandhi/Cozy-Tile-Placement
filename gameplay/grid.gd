class_name Grid extends Node2D

@export var width : int
@export var height : int

@export var position_debug : RichTextLabel

# Dictionary of Vector2i to tiles
var tiles : Dictionary = {}
@export var tile_prototype : PackedScene

@export var deck_count : RichTextLabel
@export var score_label : RichTextLabel

@export var tile_name : RichTextLabel
@export var tile_image : TextureRect
@export var tile_description : RichTextLabel
@export var tile_bonus_label : RichTextLabel

@export var build_sound : AudioStreamPlayer
@export var build_sounds : Array[AudioStream]
@export var combo_sound : AudioStreamPlayer
@export var tic_sound : AudioStreamPlayer

var deck : Array[Tile.TileType] = []
var is_menu_open : bool = true

var my_score : int = 0
var my_threshold : int = 50
var progress_on_threshold : int = 0
@export var progress_bar : TextureProgressBar
@export var points_until_threshold_label : RichTextLabel 

@export var level_up : PackedScene

@export var game_over : PackedScene
@export var entry_panel : Panel

var even_y_neighours = [
	Vector2i(-1, 1),
	Vector2i(-1, -1),
	Vector2i(0, 1),
	Vector2i(0, -1),
	Vector2i(0, 2),
	Vector2i(0, -2),
]

var odd_x_neighours = [
	Vector2i(1, 1),
	Vector2i(1, -1),
	Vector2i(0, 1),
	Vector2i(0, -1),
	Vector2i(0, 2),
	Vector2i(0, -2),
]

var drag_start : Vector2
var is_dragging : bool = false

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

func get_nearest_tile_index(pos : Vector2) -> Vector2i:
	pos = pos - self.position

	var possible_position = Vector2i((pos.x + (width / 2)) / width, (pos.y + height) / height)
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
		return Vector2(index.x * width + width / 2, index.y * height)

func get_neighbour_indices(index : Vector2i) -> Array:
	if index.y % 2 == 0:
		return even_y_neighours.map(func(x): return x + index)
	else:
		return odd_x_neighours.map(func(x): return x + index)

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

# Called when the node enters the scene tree for the first time.

func _ready():
	reset()

func reset():
	is_menu_open = false
	for tile in tiles.values():
		tile.queue_free()
	tiles.clear()
	init_deck()
	my_threshold = 50
	progress_on_threshold = 0
	update_score(0)

	add_new_tile(Vector2i(0, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_deck():
	deck = [
		Tile.TileType.Forest,
		Tile.TileType.Forest,
		Tile.TileType.Trees,
		Tile.TileType.Trees,
		Tile.TileType.Field,
		Tile.TileType.Field,
		Tile.TileType.Hill,
		Tile.TileType.Hill,
		Tile.TileType.Mountain,
		Tile.TileType.Mountain,
	]
	deck.shuffle()
	deck_count.text = "[center][font_size=50]Deck: %s" % deck.size()

func add_tile_to_position(pos : Vector2i, tile):
	if self.tiles.has(pos):
		self.tiles[pos].queue_free()

	self.tiles[pos] = tile
	tile.is_selected = false
	
	var scored = tile.calculate_score()
	
	var points = tile.floating_points.instantiate()
	tile.add_child(points)
	points.set_text(scored)
	points.position = Vector2(0, -100)

	if deck.size() == 0 and not (my_threshold <= progress_on_threshold):
		do_game_over()
		return

	update_score(my_score + scored)

	build_sound.stream = build_sounds[randi() % build_sounds.size()]
	build_sound.pitch_scale = randf_range(0.9, 1.1)
	build_sound.play()

	add_new_tile(pos)

	tile.on_place()
		

func add_new_tile(pos : Vector2i):
	var next_type = deck.pop_front()
	var new_tile = tile_prototype.instantiate()

	self.add_child(new_tile)
	new_tile.set_type(next_type)
	new_tile.position = get_tile_position(pos)
	new_tile.is_selected = true
	new_tile.grid = self
	
	deck_count.text = "[center][font_size=50]Deck: %s" % deck.size()

	tile_name.text = "[center][font_size=40][center]%s" % new_tile.get_tile_name()
	tile_image.texture = new_tile.get_tile_texture()
	tile_description.text = new_tile.get_tile_description()
	update_tile_bonus(new_tile.calculate_score())

func add_tiles(new_tiles : Array[Tile.TileType]):
	deck = deck + new_tiles
	deck_count.text = "[center][font_size=50]Deck: %s" % deck.size()

func do_game_over():
	self.is_menu_open = true
	var game_over_instance = game_over.instantiate()
	get_tree().root.add_child(game_over_instance)
	game_over_instance.set_score(my_score)
	game_over_instance.grid = self

func update_score(amt : int):
	var added = amt - my_score

	my_score = amt
	score_label.text = "[font_size=70]Score: %s" % amt

	if added > 0:
		progress_on_threshold += added
		if progress_on_threshold >= my_threshold:
			progress_on_threshold -= my_threshold
			my_threshold *= 1.2
			do_level_up()

	points_until_threshold_label.text = "[center][font_size=25]Points until next level: %s" % (my_threshold - progress_on_threshold)
	progress_bar.max_value = my_threshold
	progress_bar.value = progress_on_threshold
			
func do_level_up():
	var lvl = level_up.instantiate()
	get_tree().root.add_child(lvl)
	lvl.grid = self
	lvl.do_level_up()
	is_menu_open = true

func update_tile_bonus(bonus : int):
	if bonus > 0:
		tile_bonus_label.text = "[center][font_size=40]Current Bonus: \n[color=green]+%s" % bonus
	elif bonus < 0:
		tile_bonus_label.text = "[center][font_size=40]Current Bonus: \n[color=red]%s" % bonus
	else:
		tile_bonus_label.text = "[center][font_size=40]Current Bonus: \n%s" % bonus

	progress_bar.value = progress_on_threshold + bonus


func _on_button_pressed():
	entry_panel.queue_free()
	is_menu_open = false
	reset()
