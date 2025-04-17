extends Panel

@export var grid : Grid
var packs : Array[Pack] = [
	Pack.new_pack(
		"Nature Pack",
		"Contains all the nature tiles",
		preload("res://foundation_tiles/greenlands/2-greenlands_forest.png"),
		[
			Tile.TileType.Forest,
			Tile.TileType.Trees,
			Tile.TileType.Hill,
			Tile.TileType.Field,
		]
	),
	Pack.new_pack(
		"Town Pack",
		"Contains town tiles",
		preload("res://foundation_tiles/greenlands/11-greenlands_village.png"),
		[
			Tile.TileType.Town,
			Tile.TileType.Town,
			Tile.TileType.Town,
			Tile.TileType.Huts,
			Tile.TileType.Huts,
			Tile.TileType.Huts,
			Tile.TileType.Castle,
			Tile.TileType.Farms,
			Tile.TileType.Farms,
			Tile.TileType.Farms,
		]
	),
	Pack.new_pack(
		"Water Pack",
		"Contains water tiles",
		preload("res://foundation_tiles/greenlands/5-greenlands_water.png"),
		[
			Tile.TileType.Water,
			Tile.TileType.River,
			Tile.TileType.Lake,
			Tile.TileType.Water,
			Tile.TileType.River,
			Tile.TileType.Lake,
			Tile.TileType.Water,
			Tile.TileType.River,
			Tile.TileType.Lake,
			Tile.TileType.Swamp,
			Tile.TileType.Hole,
		]
	),
	Pack.new_pack(
		"Mountain Pack",
		"Contains mountainous tiles",
		preload("res://foundation_tiles/greenlands/9-greenlands_mountains.png"),
		[
			Tile.TileType.Mountain,
			Tile.TileType.Mountain,
			Tile.TileType.Mountain,
			Tile.TileType.Hill,
			Tile.TileType.Hill,
			Tile.TileType.Hill,
			Tile.TileType.Cave,
			Tile.TileType.Stones,
			Tile.TileType.Volcano,
		]
	),
	Pack.new_pack(
		"City Pack",
		"Contains city tiles",
		preload("res://foundation_tiles/greenlands/12-greenlands_city.png"),
		[
			Tile.TileType.Town,
			Tile.TileType.Town,
			Tile.TileType.Town,
			Tile.TileType.Town,
			Tile.TileType.Castle,
			Tile.TileType.Castle,
			Tile.TileType.Keep,
			Tile.TileType.Keep,
			Tile.TileType.Wonder,
			Tile.TileType.Tower,
			Tile.TileType.Tower,
		]
	),
	Pack.new_pack(
		"Magic Pack",
		"Contains strange tiles",
		preload("res://foundation_tiles/greenlands/24-greenlands_cristals.png"),
		[
			Tile.TileType.Portal,
			Tile.TileType.Crystals,
			Tile.TileType.Stones,
			Tile.TileType.Tower,
			Tile.TileType.Fog,
			Tile.TileType.FloatingIsland,
			Tile.TileType.Wonder,
		]
	),
	Pack.new_pack(
		"Spooky Pack",
		"Contains spooky tiles",
		preload("res://foundation_tiles/greenlands/19-greenlands_graveyard.png"),
		[
			Tile.TileType.DeadTrees,
			Tile.TileType.DeadTrees,
			Tile.TileType.Ruin,
			Tile.TileType.Bones,
			Tile.TileType.Bones,
			Tile.TileType.Swamp,
			Tile.TileType.Fog,
			Tile.TileType.Cave,
		]
	),
	Pack.new_pack(
		"Flatlands Pack",
		"Contains flat tiles",
		preload("res://foundation_tiles/greenlands/3-greenlands_tundra.png"),
		[
			Tile.TileType.Swamp,
			Tile.TileType.Swamp,
			Tile.TileType.Swamp,
			Tile.TileType.Field,
			Tile.TileType.Field,
			Tile.TileType.Field,
			Tile.TileType.River,
			Tile.TileType.River,
			Tile.TileType.River,
		]
	),
]
var my_packs : Array[Pack] = []

@export var texture1 : TextureRect
@export var texture2 : TextureRect
@export var texture3 : TextureRect
@export var text1 : RichTextLabel
@export var text2 : RichTextLabel
@export var text3 : RichTextLabel

func do_level_up():
	self.visible = true

	var index1 = randi() % packs.size()
	var index2 = randi() % packs.size()

	while index2 == index1:
		index2 = randi() % packs.size()

	var index3 = randi() % packs.size()

	while index3 == index1 or index3 == index2:
		index3 = randi() % packs.size()

	my_packs = [
		packs[index1],
		packs[index2],
		packs[index3],
	]

	texture1.texture = my_packs[0].image
	texture2.texture = my_packs[1].image
	texture3.texture = my_packs[2].image

	text1.text = "[center][font_size=40]%s:\n[font_size=20]%s" % [my_packs[0].pack_name, my_packs[0].description]
	text2.text = "[center][font_size=40]%s:\n[font_size=20]%s" % [my_packs[1].pack_name, my_packs[1].description]
	text3.text = "[center][font_size=40]%s:\n[font_size=20]%s" % [my_packs[2].pack_name, my_packs[2].description]

func on_select(index : int):
	var tiles : Array[Tile.TileType] = []

	for i in range(5):
		tiles.append(my_packs[index].tiles[randi() % my_packs[index].tiles.size()])
	
	grid.add_tiles(
		tiles
	)

	self.visible = false
	grid.is_menu_open = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
