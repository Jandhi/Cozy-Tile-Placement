class_name Tags

enum Tag {
	Sylvan,
	Aquatic,
    Legendary,
}

static var tag_names : Dictionary[Tags.Tag, String] = {
    Tags.Tag.Sylvan : "Sylvan",
    Tags.Tag.Aquatic : "Aquatic",
    Tags.Tag.Legendary : "Legendary",
}

static var tag_colors : Dictionary[Tags.Tag, Color] = {
	Tags.Tag.Sylvan : Color.from_string("#27b317", Color.WHITE),
    Tags.Tag.Aquatic : Color.from_string("#06437d", Color.WHITE),
    Tags.Tag.Legendary : Color.from_string("#b3a317", Color.WHITE),
}