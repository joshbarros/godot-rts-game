## player_unit.gd - Player unit helper for selection visuals
##
## WHAT THIS DOES:
## - Toggles the selection visual (green indicator) on/off
## - Called by unit_controller.gd when selecting/deselecting units
##
## USED BY: unit_player.tscn (PlayerUnit node)

extends Node

@onready var selection_visual = $"../SelectionVisual"  # Green selection sprite


# PUBLIC: Show/hide the selection indicator
# Called by unit_controller.gd
func toggle_selection_visual(toggle : bool):
	selection_visual.visible = toggle