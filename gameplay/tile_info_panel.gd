class_name TileInfoPanel extends Panel

@export var tags_container : TagsContainer


func _ready():
	tags_container.spawn_tag(Tags.Tag.Sylvan)
	tags_container.spawn_tag(Tags.Tag.Aquatic)
