class_name DeckSelection extends Panel

@export var game_scene : PackedScene
@export var deck_button_prefab : PackedScene
@export var deck_button_container : Container
var decks : Array[StartingDeck] = []

func _ready():
	load_all_decks()

	decks.shuffle()

	for i in range(3):
		var deck_button = deck_button_prefab.instantiate()
		deck_button.set_deck(decks[i])
		deck_button_container.add_child(deck_button)
		deck_button.deck_selected.connect(func(deck : StartingDeck):
			var game_scene_instance = game_scene.instantiate()
			get_parent().add_child(game_scene_instance)
			game_scene_instance.find_child("GameManager").start_game(deck)
			queue_free()
		)

func load_all_decks():
	var tile_paths = get_all_file_paths("res://gameplay/starting_decks")
	for path in tile_paths:
		var deck = load(path)
		if deck is StartingDeck:
			decks.append(deck)

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
