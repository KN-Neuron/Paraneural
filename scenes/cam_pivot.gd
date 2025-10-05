extends Marker3D

var mouse_sensitivity = 0.002

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			rotate_x(-event.relative.y * mouse_sensitivity)
