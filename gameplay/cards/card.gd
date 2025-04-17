class_name Card extends Control

@export var name_label : RichTextLabel
@export var type_label : RichTextLabel
@export var image : TextureRect
@export var tags_container : TagsContainer
@export var description_label : RichTextLabel

@export_group("Card Images")
@export var terrain : Texture
@export var building : Texture
@export var denizen : Texture
var textures : Dictionary[TileInfo.Tiletype, Texture] = {
	TileInfo.Tiletype.TERRAIN: terrain,
	TileInfo.Tiletype.BUILDING: building,
	TileInfo.Tiletype.DENIZEN: denizen
}

var card_info : CardInfo

func set_card_info(info : CardInfo):
	if info.type == CardInfo.CardType.TILE:
		name_label.text = "[center][color=white][b]" + info.tile_info.tile_name
		type_label.text = "[center][color=white][i]" + TileInfo.tile_type_names[info.tile_info.tile_type]
		image.texture = textures[info.tile_info.tile_type]
		image.self_modulate = info.tile_info.tile_color
		tags_container.set_tags(info.tile_info.tags)
		description_label.text = info.tile_info.tile_description
