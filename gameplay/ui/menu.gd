extends Control

@export var game_prefab : PackedScene

func _on_play_button_pressed():
	# Start the game
	print("Play button pressed")

	var game_instance = game_prefab.instantiate()
	get_tree().root.add_child(game_instance)
	var game_manager = game_instance.get_node("GameManager")
	game_manager.start_game()
	queue_free()
