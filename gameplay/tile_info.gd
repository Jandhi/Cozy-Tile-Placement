class_name TileInfo extends Resource

enum Tiletype {
    TERRAIN,
    BUILDING,
    DENIZEN
}

static var tile_type_names : Dictionary[Tiletype, String] = {
    Tiletype.TERRAIN: "Terrain",
    Tiletype.BUILDING: "Building",
    Tiletype.DENIZEN: "Denizen"
}

@export var tile_name : String
@export var tile_description : String
@export var tile_type : Tiletype
@export var tile_color : Color
@export var tags : Array[Tags.Tag]