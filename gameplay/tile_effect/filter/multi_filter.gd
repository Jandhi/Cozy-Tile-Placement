class_name MultiFilter extends TileFilter

@export var filters : Array[TileFilter]

func fits(tile : Tile) -> bool:
	for filter in filters:
		if filter.fits(tile):
			return true
	return false