class_name TagDisplay extends NinePatchRect





@export var label : RichTextLabel

func set_tag(tag : String, color : Color, text_is_light : bool = true):
	self.self_modulate = color
	self.custom_minimum_size = Vector2(label.get_theme_font("normal font").get_string_size(tag).x + 4, 0)

	var text_color = "white"

	if not text_is_light:
		text_color = "black"

	label.text = "[center][color=" + text_color + "]" + tag
	
