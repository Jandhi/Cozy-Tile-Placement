class_name Tile extends Node2D

@export var sprite : Sprite2D
@export var label : RichTextLabel
@export var cannot_place : Sprite2D

@export var terrain_texture : Texture2D
@export var building_texture : Texture2D
@export var denizen_texture : Texture2D

var tile_info : TileInfo = null
var tile_position : Vector2i = Vector2i.ZERO

func set_tile(info : TileInfo):
	tile_info = info
	var brightness = info.tile_color.r * 0.299 + info.tile_color.g * 0.587 + info.tile_color.b * 0.114
	var text_is_white = brightness < 0.5
	label.text = "[center][color=" + ("white" if text_is_white else "black") + "][b]" + info.tile_name
	
	if info.tile_type == TileInfo.Tiletype.TERRAIN:
		sprite.texture = terrain_texture
		sprite.z_index = 0
		sprite.position = Vector2.ZERO
		label.position = Vector2(-64, -100)
		label.z_index = 0
	elif info.tile_type == TileInfo.Tiletype.BUILDING:
		sprite.texture = building_texture
		sprite.z_index = 1
		sprite.position = Vector2(0, -30)
		label.position = Vector2(-64, -40)
		label.z_index = 1
	elif info.tile_type == TileInfo.Tiletype.DENIZEN:
		sprite.texture = denizen_texture
		sprite.z_index = 2
		sprite.position = Vector2(0, 30)
		label.position = Vector2(-64, 40)
		label.z_index = 2

	sprite.self_modulate = info.tile_color
