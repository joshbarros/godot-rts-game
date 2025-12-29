## camera_controller.gd - Camera movement and zoom controls
##
## WHAT THIS DOES:
## - Pan camera with WASD keys
## - Zoom in/out with mouse scroll wheel
##
## CONTROLS:
## - W/A/S/D: Pan camera up/left/down/right
## - Mouse wheel up: Zoom in
## - Mouse wheel down: Zoom out
##
## INPUT MAPPINGS (defined in project.godot):
## - cam_left, cam_right, cam_up, cam_down (WASD)
## - zoom_in, zoom_out (mouse wheel)
##
## USED BY: main.tscn (Camera2D node)

extends Camera2D

# === SETTINGS ===
@export var move_speed : float = 70.0   # Camera pan speed
@export var zoom_amount : float = 0.2   # Zoom step per scroll


# Process camera movement and zoom each frame
func _process(delta):
	_move(delta)
	_zoom(delta)


# Handle WASD camera panning
func _move(delta):
	var input = Input.get_vector("cam_left", "cam_right", "cam_up", "cam_down")
	var _zoom_mod = 6.0 - zoom.x  # TODO: Could make pan faster when zoomed out

	global_position += input * move_speed * delta


# Handle mouse wheel zoom
func _zoom(delta):
	var z = zoom.x

	if Input.is_action_just_released("zoom_in"):
		z += zoom_amount
	elif Input.is_action_just_released("zoom_out"):
		z -= zoom_amount

	z = clamp(z, 1.0, 5.0)  # Min 1x, max 5x zoom

	zoom.x = z
	zoom.y = z