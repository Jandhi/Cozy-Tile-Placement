class_name SeasonDisplay extends Control

@export var title_label : RichTextLabel
@export var progress_bar : ProgressBar
@export var points_label : RichTextLabel
@export var effect_label : RichTextLabel
@export var days_left_label : RichTextLabel

func set_season(title : String, points_threshold : int, effect : String, length : int):
	title_label.text = "[center][b]" + title
	progress_bar.value = 0
	progress_bar.max_value = points_threshold
	points_label.text = "0 / %s" % (points_threshold)
	effect_label.text = "[center]" + effect
	days_left_label.text = "[right]%s Turns Left" % length


func set_progress(points : int, threshold : int):
	progress_bar.value = points
	points_label.text = "0 / %s" % (threshold)