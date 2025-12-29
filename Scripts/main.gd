## main.gd - Main game controller and win condition handler
##
## WHAT THIS DOES:
## - Tracks unit counts per team
## - Detects when a team wins (all enemies dead)
## - Shows victory/defeat screen
##
## HOW IT WORKS:
## - On start: counts all units by team, connects to OnDie signals
## - When unit dies: decrements count, checks if only one team remains
## - If one team left: shows end screen with winner
##
## USED BY: main.tscn (root node)

extends Node2D

# Unit count per team - tracks how many alive
var units = {
	Unit.Team.PLAYER: 0,
	Unit.Team.AI: 0
}

@onready var end_screen = $CanvasLayer/EndScreen  # Victory/defeat panel


# Initialize: count all units and connect to death signals
func _ready():
	for unit in get_tree().get_nodes_in_group("Unit"):
		if unit is not Unit:
			continue

		units[unit.team] += 1
		unit.OnDie.connect(_on_unit_die)


# Called when any unit dies - update count and check for winner
func _on_unit_die(unit : Unit):
	units[unit.team] -= 1
	_check_win_condition()


# Check if only one team has units remaining
func _check_win_condition():
	var winner = 0
	var teams_alive = 0

	for team in units:
		if units[team] > 0:
			teams_alive += 1
			winner = team

	# Game continues if multiple teams still alive
	if teams_alive > 1:
		return

	# Show winner
	var team_name = Unit.Team.keys()[winner]
	end_screen.set_screen(team_name)
