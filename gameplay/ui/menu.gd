extends Control

@export var deck_selection : PackedScene

func _on_play_button_pressed():
	# Start the game

	var deck_selection_instance = deck_selection.instantiate()
	get_tree().root.add_child(deck_selection_instance)
	queue_free()
