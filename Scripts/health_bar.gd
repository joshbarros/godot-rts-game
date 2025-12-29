## health_bar.gd - Health bar display above units
##
## WHAT THIS DOES:
## - Shows a progress bar representing unit health
## - Hidden when at full health (clean look)
## - Appears when damaged, updates in real-time
##
## HOW IT WORKS:
## - Listens to OnTakeDamage signal from parent unit
## - Updates value and visibility when health changes
##
## USED BY: unit_base.tscn (HealthBar node)

extends ProgressBar

@onready var unit : Unit = get_parent()  # Parent unit


# Initialize health bar and connect to damage signal
func _ready():
	max_value = unit.max_hp
	value = max_value
	visible = false  # Hidden at full health

	unit.OnTakeDamage.connect(_update_value)


# Update health bar when damage is taken
# Shows bar only when health is below max
func _update_value(health : int):
	value = health
	visible = value < max_value  # Show only when damaged