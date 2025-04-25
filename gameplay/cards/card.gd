class_name Card extends Control

@export var name_label : RichTextLabel
@export var type_label : RichTextLabel
@export var image : TextureRect
@export var tags_container : TagsContainer
@export var description_label : RichTextLabel
@export var point_origin : Control

@export_group("Card Images")
@export var terrain : Texture
@export var building : Texture
@export var denizen : Texture

var card_info : CardInfo
var is_discarded : bool = false

func set_card_info(info : CardInfo):
	card_info = info

	if info.type == CardInfo.CardType.TILE:
		name_label.text = "[center][color=white][b]" + info.tile_info.tile_name
		type_label.text = "[center][color=white][i]" + TileInfo.tile_type_names[info.tile_info.tile_type]
		
		match info.tile_info.tile_type:
			TileInfo.Tiletype.TERRAIN:
				image.texture = terrain
			TileInfo.Tiletype.BUILDING:
				image.texture = building
			TileInfo.Tiletype.DENIZEN:
				image.texture = denizen

		image.self_modulate = info.tile_info.tile_color
		tags_container.set_tags(info.tile_info.tags)
		description_label.text = Tags.parse_tags(info.tile_info.tile_description)