class_name StartingDeck extends Resource

@export var deck_name : String
@export var deck_description : String
@export var deck_picture : Texture2D
@export var cards : Dictionary[TileInfo, int]

func get_cards() -> Array[TileInfo]:
	var card_list : Array[TileInfo] = []
	for card in cards.keys():
		for i in range(cards[card]):
			card_list.append(card)
	return card_list