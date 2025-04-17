class_name TagsContainer extends Container

@export var tag_prefab : PackedScene

func set_tags(tags : Array[Tags.Tag]):
	for child in get_children():
		child.queue_free()

	for tag in tags:
		spawn_tag(tag)

func spawn_tag(tag : Tags.Tag):
	var tag_name : String = Tags.tag_names[tag]
	var color : Color = Tags.tag_colors[tag]
	var tag_instance : TagDisplay = tag_prefab.instantiate()
	var brightness = color.r * 0.299 + color.g * 0.587 + color.b * 0.114
	var text_is_white = brightness < 0.5
	tag_instance.set_tag(tag_name, color, text_is_white)
	self.add_child(tag_instance)
