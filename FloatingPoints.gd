extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween().set_parallel(true)

	tween.tween_property($RichTextLabel, "modulate:a", 0.0, 1)
	tween.tween_property(self, "position", self.position + Vector2(0, -150), 1)

	await get_tree().create_timer(1.2).timeout
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_text(amt: int) -> void:
	if amt > 0:
		$RichTextLabel.text = "[color=green][font_size=50][center]+%s" % amt
	elif amt < 0:
		$RichTextLabel.text = "[color=red][font_size=50][center]%s" % amt
	else:
		$RichTextLabel.text = "[font_size=50][center]%s" % amt