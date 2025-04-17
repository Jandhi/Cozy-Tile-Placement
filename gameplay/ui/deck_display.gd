class_name DeckDisplay extends TextureRect

@export var number_label : RichTextLabel
@export var text_color : String

func set_number(amount : int):
    number_label.text = "[center][color=" + text_color + "][b]" + str(amount)