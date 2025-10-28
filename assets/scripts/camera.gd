extends Camera2D

var dragging := false
var last_mouse_position := Vector2.ZERO
var limit = 80
var scroll_speed = 100.0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				last_mouse_position = event.position
			else:
				dragging = false

	elif event is InputEventMouseMotion and dragging:
		var delta_t = event.position - last_mouse_position
		delta_t.x = 0
		if global_position.y - delta_t.y < 0:
			delta_t.y = 0
		elif global_position.y - delta_t.y > limit:
			delta_t.y = limit
		global_position -= delta_t
		last_mouse_position = event.position
	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			global_position.y -= scroll_speed
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			global_position.y += scroll_speed
		
		if global_position.y< 0:
			global_position.y = 0
		elif global_position.y > limit:
			global_position.y = limit
		
