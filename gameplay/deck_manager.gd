class_name DeckManager extends Node

@export var deck_view_prototype : PackedScene
@export var hand : Hand

signal discard_count_changed(count : int)
signal draw_pile_count_changed(count : int)

var deck : Array[CardInfo] = []
var draw_pile : Array[CardInfo] = []
var discard_pile : Array[CardInfo] = []
var exhaust_pile : Array[CardInfo] = []

func _ready() -> void:
	for i in range(20):
		add_test_card()

	for i in range(5):
		draw_card()

func add_test_card():
	var info = CardInfo.new()
	info.type = CardInfo.CardType.TILE

	match randi() % 3:
		0:
			info.tile_info = load("res://gameplay/tiles/lumberjack.tres")
		1:
			info.tile_info = load("res://gameplay/tiles/lumber_mill.tres")
		2:
			info.tile_info = load("res://gameplay/tiles/forest.tres")

	deck.append(info)
	draw_pile.append(info)
	discard_count_changed.emit(discard_pile.size())
	
func add_card_to_discard(card : Card):
	discard_pile.append(card.card_info)
	discard_count_changed.emit(discard_pile.size())

func draw_card():
	if draw_pile.size() == 0:
		reshuffle_deck()

	var card_info : CardInfo = draw_pile.pop_back()
	hand.spawn_card(card_info)
	draw_pile_count_changed.emit(draw_pile.size())

func reshuffle_deck():
	if discard_pile.size() == 0:
		return
	
	draw_pile = discard_pile
	draw_pile.shuffle()
	discard_pile = []

	draw_pile_count_changed.emit(draw_pile.size())
	discard_count_changed.emit(discard_pile.size())

func open_deck_view():
	var deck_view : DeckView = deck_view_prototype.instantiate()
	get_tree().get_root().add_child(deck_view)
	deck_view.init_with("Deck", deck)

func open_discard_view():
	var deck_view : DeckView = deck_view_prototype.instantiate()
	get_tree().get_root().add_child(deck_view)
	deck_view.init_with("Discard", discard_pile)
