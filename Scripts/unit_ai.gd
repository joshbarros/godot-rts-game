## unit_ai.gd - AI behavior for enemy units
##
## WHAT THIS DOES:
## - Automatically detects and targets player units
## - Finds the CLOSEST player unit and attacks it
## - Runs detection on a timer (not every frame) for performance
##
## HOW IT WORKS:
## - Every 0.2 seconds, scans all units in "UnitPlayer" group
## - Finds the closest one and sets it as attack target
## - The actual attacking is handled by unit_base.gd
##
## USED BY: unit_ai.tscn (child of Unit_AI)

extends Node

# === SETTINGS ===
@export var detect_range : float = 100.0  # Detection radius (currently unused, attacks any distance)
@export var detect_rate : float = 0.2     # Seconds between detection checks
var last_detect_time : float               # Timestamp of last detection
var enemy_list : Array[Unit] = []          # Cached list of player units

@onready var unit : Unit = get_parent()    # The unit this AI controls


# Runs detection check on a timer for performance
func _process(delta):
	var time = Time.get_unix_time_from_system()

	if time - last_detect_time > detect_rate:
		last_detect_time = time
		_update_enemy_list()
		_detect()


# Refreshes the list of player units from "UnitPlayer" group
func _update_enemy_list():
	enemy_list.clear()

	var raw_list = get_tree().get_nodes_in_group("UnitPlayer")

	for node in raw_list:
		if node is not Unit:
			continue
		enemy_list.append(node)


# Finds closest player unit and sets it as attack target
func _detect():
	var closest_enemy = null
	var closest_distance = 999999

	for enemy in enemy_list:
		var dist = unit.global_position.distance_to(enemy.global_position)

		if dist < closest_distance:
			closest_enemy = enemy
			closest_distance = dist

	if closest_enemy != null:
		unit.set_attack_target(closest_enemy)