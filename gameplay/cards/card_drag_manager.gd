class_name CardDragManager extends Node2D

@export var hand : Hand
@export var grid : Grid

var pointer_position : Vector2
var hovered_card : Card = null
var clicked : bool = false

func _draw():
	if clicked and hovered_card != null:
		var curve = Curve2D.new()

		curve.add_point(hovered_card.point_origin.global_position, Vector2(0, 0), Vector2.UP * max((hovered_card.point_origin.global_position.y - pointer_position.y), 100.0))
		curve.add_point(pointer_position, Vector2(0, 0), Vector2(0, 0))

		curve.bake_interval = 5.0

		draw_polyline(curve.get_baked_points(), Color.YELLOW, 12.0)
	
func _ready() -> void:
	hand.card_hovered.connect(func(card : Card):
		if not clicked:
			hovered_card = card
	)
	hand.card_unhovered.connect(func(_card : Card):
		if not clicked:
			hovered_card = null
	)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# We don't care if no card is hovered
		if hovered_card == null:
			return

		if event.pressed:
			clicked = true
			grid.spawn_preview(hovered_card)
			hand.lock_selected()
		else:
			clicked = false
			hand.unlock_selected()

			if grid.can_place_preview():
				grid.place_preview()
				hand.discard(hovered_card)
			else:
				grid.remove_preview()

			hovered_card = null
			

	if event is InputEventMouseMotion:
		pointer_position = event.position
		queue_redraw()
