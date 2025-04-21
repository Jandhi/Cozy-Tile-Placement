class_name DeckView extends Control

@export var card_prototype : PackedScene
@export var card_container : GridContainer
@export var title_label : RichTextLabel

func init_with(title : String, cards : Array[CardInfo]):
	title_label.text = "[center][b]" + title
	for card in cards:
		var new_card = card_prototype.instantiate()
		card_container.add_child(new_card)
		new_card.get_child(0).set_card_info(card)

	card_container.columns = int(size.x / 250)

func exit() -> void:
	queue_free()
