## unit_controller.gd - Handles player mouse input for unit selection and commands
##
## WHAT THIS DOES:
## - Left-click: Select a player unit (shows selection visual)
## - Right-click: Command selected unit to move or attack
##
## HOW IT WORKS:
## - Uses physics point queries to detect units under mouse cursor
## - Only allows selecting PLAYER team units
## - Right-click on enemy = attack command
## - Right-click on ground = move command
##
## USED BY: main.tscn (UnitController node)

extends Node2D

var selected_unit : Unit  # Currently selected unit (null = none)


# Handles all mouse input for selection and commands
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_try_select_unit()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			_try_command_unit()


# Left-click: Try to select a unit under cursor
# Only selects PLAYER team units, deselects if clicking elsewhere
func _try_select_unit():
	var unit = _get_selected_unit()

	if unit == null or unit.team != Unit.Team.PLAYER:
		_unselect_unit()
	else:
		_select_unit(unit)


# Selects a unit and shows its selection visual
func _select_unit(unit: Unit):
	_unselect_unit()  # Deselect previous first
	selected_unit = unit
	var player_unit = unit.get_node_or_null("PlayerUnit")
	if player_unit:
		player_unit.toggle_selection_visual(true)


# Deselects current unit and hides selection visual
func _unselect_unit():
	if selected_unit != null:
		var player_unit = selected_unit.get_node_or_null("PlayerUnit")
		if player_unit:
			player_unit.toggle_selection_visual(false)
	selected_unit = null


# Right-click: Issue command to selected unit
# Click on enemy = attack, click on ground = move
func _try_command_unit():
	if selected_unit == null:
		return

	var target = _get_selected_unit()

	if target != null:
		# Clicked on a unit - attack if enemy
		if target.team != Unit.Team.PLAYER:
			selected_unit.set_attack_target(target)
	else:
		# Clicked on ground - move there
		selected_unit.set_move_to_target(get_global_mouse_position())


# Uses physics query to find unit under mouse cursor
# Returns null if no unit found
func _get_selected_unit() -> Unit:
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	var intersection = space.intersect_point(query, 1)

	if intersection.is_empty():
		return null

	if intersection[0].collider is not Unit:
		return null

	return intersection[0].collider
