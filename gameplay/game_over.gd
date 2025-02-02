class_name GameOver extends Control

var grid : Grid

func set_score(score):
	$Score.text = "[font_size=40][center]Game Over\nYou got [color=yellow]%s[/color] points" % score


func on_try_again():
	grid.reset()
	grid.is_menu_open = false
	queue_free()