class_name DeckButton extends Panel

signal deck_selected(new_deck : StartingDeck)

@export var title : RichTextLabel
@export var description : RichTextLabel
var deck : StartingDeck

func set_deck(new_deck : StartingDeck):
	self.deck = new_deck
	title.text = "[center][b]%s" % new_deck.deck_name
	description.text = new_deck.deck_description

func selected():
	deck_selected.emit(deck)
