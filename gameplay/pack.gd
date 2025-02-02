class_name Pack extends Resource

@export var pack_name : String
@export var description : String
@export var image : Texture
@export var tiles : Array[Tile.TileType]

static func new_pack(pack_name : String, description : String, image : Texture, tiles : Array[Tile.TileType]) -> Pack:
    var pack = Pack.new()
    pack.pack_name = pack_name
    pack.description = description
    pack.image = image
    pack.tiles = tiles
    return pack