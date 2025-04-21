class_name Hand extends Control

signal card_hovered(card : Card)
signal card_unhovered(card : Card)
signal deck_clicked()
signal discard_clicked()

signal card_discarded(card : Card)

@export var hand_size : int = 5
@export var card_container : Control
@export var card_prefab : PackedScene
@export var deck_display : DeckDisplay
@export var discard_display : DeckDisplay

var cards : Array[Card] = []
var card_tween : Tween = null
var is_selected_locked : bool = false

func _ready():
	deck_display.gui_input.connect(func(event):
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			deck_clicked.emit())
	discard_display.gui_input.connect(func(event):
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			discard_clicked.emit())

func set_deck_count(amount : int):
	deck_display.set_number(amount)

func set_discard_count(amount : int):
	discard_display.set_number(amount)

func lock_selected():
	is_selected_locked = true

func unlock_selected():
	is_selected_locked = false
	organize_cards()

func spawn_card(card_info : CardInfo):
	var card_instance : Card = card_prefab.instantiate()
	card_instance.set_card_info(card_info)
	card_instance.mouse_entered.connect(func():
		_on_card_hovered(card_instance))
	card_instance.mouse_exited.connect(func():
		_on_card_unhovered(card_instance))
	card_container.add_child(card_instance)
	card_instance.global_position = deck_display.global_position
	cards.append(card_instance)

	organize_cards()

func organize_cards(except_index : int = -1):
	if card_tween != null:
		card_tween.stop()

	card_tween = get_tree().create_tween().set_parallel()

	for i in range(cards.size()):
		if i == except_index:
			continue

		var card : Card = cards[i]
		card_tween.tween_property(card, "global_position", Vector2(
			calculate_card_x(i, cards.size()),
			card_container.position.y + abs(cards.size() / 2.0 - i) * 10
		), 0.1)

		var angle = (i - (cards.size() - 1) / 2.0) * 5
		card_tween.tween_property(card, "rotation_degrees", angle, 0.1)

func calculate_card_x(index : int, card_amount : int):
	var midpoint = card_container.position.x + card_container.size.x / 2

	var spacing = 220.0

	if card_amount > 6:
		spacing = 220.0 - 15 * (card_amount - 6)

	return (index - (card_amount / 2.0)) * spacing + midpoint

func _on_card_hovered(card : Card):
	if card.is_discarded:
		return

	card_hovered.emit(card)
	card.z_index = 1

	if is_selected_locked:
		return

	if card_tween != null:
		card_tween.stop()

	var index = cards.find(card)
	organize_cards(index)

	card_tween.tween_property(card, "global_position", Vector2(
		calculate_card_x(index, cards.size()),
		card_container.position.y - 100.0
	), 0.1)
	card_tween.tween_property(card, "rotation_degrees", 0.0, 0.1)

func _on_card_unhovered(card : Card):
	if card.is_discarded:
		return

	card_unhovered.emit(card)

	if is_selected_locked:
		return

	card.z_index = 0
	organize_cards()

func discard_hand():
	while cards.size() > 0:
		await discard(cards[0])

	cards.clear()

func discard(card : Card):
	card_discarded.emit(card)
	card.z_index = 0
	card.is_discarded = true
	cards.erase(card)
	organize_cards()

	await get_tree().create_tween()\
		.tween_property(card, "global_position", discard_display.global_position, 0.15).finished
	card.queue_free()
