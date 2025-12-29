## sprite.gd - Unit sprite animations and visual feedback
##
## WHAT THIS DOES:
## - Wobble animation: Unit wobbles side-to-side when moving
## - Directional flip: Sprite faces left/right based on movement direction
## - Damage flash: Brief red tint when taking damage
##
## HOW IT WORKS:
## - Wobble uses sin() wave, only when position changes between frames
## - Flip checks X direction of movement
## - Flash connects to OnTakeDamage signal from unit_base.gd
##
## USED BY: unit_base.tscn (Sprite node)

extends Sprite2D

@onready var unit : Unit = get_parent()  # Parent unit

var unit_pos_last_frame : Vector2  # For detecting movement


# Connect to damage signal for flash effect
func _ready():
	unit.OnTakeDamage.connect(_damage_flash)


# Handles wobble animation and sprite flip each frame
func _process(delta: float):
	# --- WOBBLE ANIMATION ---
	var time = Time.get_unix_time_from_system()
	var r = sin(time * 10) * 5  # Oscillate between -5 and +5 degrees

	# Only wobble when moving (position changed since last frame)
	if unit.global_position.distance_to(unit_pos_last_frame) == 0:
		r = 0  # Not moving = no wobble

	rotation = deg_to_rad(r)

	# --- DIRECTIONAL FLIP ---
	var dir = unit.global_position.x - unit_pos_last_frame.x
	if dir > 0:
		flip_h = false  # Moving right = face right
	elif dir < 0:
		flip_h = true   # Moving left = face left

	# Save position for next frame comparison
	unit_pos_last_frame = unit.global_position


# Flash red briefly when taking damage
# Called via OnTakeDamage signal from unit_base.gd
func _damage_flash(health : int):
	modulate = Color.RED
	await get_tree().create_timer(0.05).timeout
	modulate = Color.WHITE