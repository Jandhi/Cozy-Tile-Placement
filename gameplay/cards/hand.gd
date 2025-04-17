class_name Hand extends Control

@export var hand_size : int = 5
@export var card_container : Control
@export var card_prefab : PackedScene
@export var deck_display : DeckDisplay
@export var discard_display : DeckDisplay

var cards : Array[Card] = []
var card_tween : Tween = null

func _ready():
	# Initialize the hand with empty cards
	for i in range(hand_size):
		var info = CardInfo.new()
		info.tile_info = load("res://gameplay/tiles/forest.tres")
		spawn_card(info)

func spawn_card(card_info : CardInfo):
	var card_instance : Card = card_prefab.instantiate()
	card_instance.set_card_info(card_info)
	card_instance.mouse_entered.connect(func():
		_on_card_hovered(card_instance))
	card_instance.mouse_exited.connect(func():
		_on_card_unhovered(card_instance))
	card_container.add_child(card_instance)
	card_instance.global_position = deck_display.global_position

	organize_cards()

func organize_cards():
	if card_tween != null:
		card_tween.stop()

	card_tween = get_tree().create_tween().set_parallel()

	var midpoint = card_container.position.x + card_container.size.x / 2

	for i in range(card_container.get_child_count()):
		var card : Card = card_container.get_child(i)
		card_tween.tween_property(card, "global_position", Vector2(midpoint + (i - hand_size / 2.0) * 100.0, card_container.position.y), 0.5)

func _on_card_hovered(card : Card):
	# Handle card hover event
	print("Card hovered: ", card.card_info.tile_info.name)

func _on_card_unhovered(card : Card):
	# Handle card unhover event
	print("Card unhovered: ", card.card_info.tile_info.name)
