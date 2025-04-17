class_name TileInfoPanel extends Panel

@export var tags_container : TagsContainer


func _ready():
	tags_container.spawn_tag("Sylvan", Color.GREEN)
	tags_container.spawn_tag("Aquatic", Color.BLUE)
