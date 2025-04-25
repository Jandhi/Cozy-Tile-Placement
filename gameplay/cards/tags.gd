class_name Tags

enum Tag {
	Sylvan,
	Aquatic,
    Legendary,
}

static var tags_list : Array[Tag] = [
    Tag.Sylvan,
    Tag.Aquatic,
    Tag.Legendary,
]

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

static func parse_tags(text : String) -> String:
    for tag in tags_list:
        text = text.replace(tag_names[tag], "[color=" + tag_colors[tag].to_html() + "]" + tag_names[tag] + "[/color]")

    return text