class_name TileManager extends Node

var tiles : Array[TileInfo] = []
var terrains : Array[TileInfo] = []
var buildings : Array[TileInfo] = []
var denizens : Array[TileInfo] = []

func _ready():
	load_all_tiles()

func load_all_tiles():
	var tile_paths = get_all_file_paths("res://gameplay/tiles")
	for path in tile_paths:
		var tile_info = load(path)

		assert(tile_info is TileInfo, "Loaded resource is not a TileInfo")

		tiles.append(tile_info)
		
		match tile_info.tile_type:
			TileInfo.Tiletype.TERRAIN:
				terrains.append(tile_info)
			TileInfo.Tiletype.BUILDING:
				buildings.append(tile_info)
			TileInfo.Tiletype.DENIZEN:
				denizens.append(tile_info)

func get_all_file_paths(path: String) -> Array[String]:  
	var file_paths: Array[String] = []  
	var dir = DirAccess.open(path)  
	dir.list_dir_begin()  
	var file_name = dir.get_next()  
	while file_name != "":  
		var file_path = path + "/" + file_name  
		if dir.current_is_dir():  
			file_paths += get_all_file_paths(file_path)  
		else:  
			file_paths.append(file_path)  
		file_name = dir.get_next()  
	return file_paths