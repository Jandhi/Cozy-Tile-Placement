class_name Tags

enum Tag {
    # Terrain
    Sylvan,
    Aquatic,
    Flatlands,
    Subterranean,
    
    Legendary,
}

static var tags_list: Array[Tag] = [
    Tag.Sylvan,
    Tag.Aquatic,
    Tag.Flatlands,

    Tag.Subterranean,
    Tag.Legendary,
]

static var tag_names: Dictionary[Tags.Tag, String] = {
    Tags.Tag.Sylvan       : "Sylvan",
    Tags.Tag.Aquatic      : "Aquatic",
    Tags.Tag.Flatlands    : "Flatlands",

    Tags.Tag.Subterranean : "Subterranean",
    Tags.Tag.Legendary    : "Legendary",
}

static var tag_colors: Dictionary[Tags.Tag, Color] = {
    Tags.Tag.Sylvan       : hex_color("#27b317"),
    Tags.Tag.Aquatic      : hex_color("#06437d"),
    Tags.Tag.Flatlands    : hex_color("#d1b317"),
    Tags.Tag.Subterranean : hex_color("#403124"),
    Tags.Tag.Legendary    : hex_color("#b3a317"),
}

static func parse_tags(text: String) -> String:
    for tag in tags_list:
        text = text.replace(
            tag_names[tag],
            "[color=" + tag_colors[tag].to_html() + "]" + tag_names[tag] + "[/color]"
        )
    return text

static func hex_color(hex: String) -> Color:
    return Color.from_string(hex, Color.WHITE)