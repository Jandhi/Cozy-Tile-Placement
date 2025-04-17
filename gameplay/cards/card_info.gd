class_name CardInfo extends Resource

# For now, I'll have this always be a tile

enum CardType {
    TILE,
    ACTION
}

var type : CardType
@export var tile_info : TileInfo
