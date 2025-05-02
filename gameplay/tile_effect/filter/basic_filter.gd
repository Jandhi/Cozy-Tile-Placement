class_name BasicFilter extends TileFilter

@export var required_name : String
@export var excluded_name : String
@export var required_tags : Array[Tags.Tag]
@export var excluded_tags : Array[Tags.Tag]

func fits(tile : Tile) -> bool:
	return required_tags.all(func (tag : Tags.Tag):
		return tile.tile_info.tags.has(tag)
	) and excluded_tags.all(func (tag : Tags.Tag):
		return not tile.tile_info.tags.has(tag)
	) and (required_name == "" or required_name == tile.tile_info.tile_name) \
	and (excluded_name == "" or excluded_name != tile.tile_info.tile_name)