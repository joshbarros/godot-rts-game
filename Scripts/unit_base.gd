## unit_base.gd - Core unit class for all units (player and AI)
##
## WHAT THIS DOES:
## - Movement using NavigationAgent2D pathfinding
## - Health system with damage and death
## - Combat with attack targeting and rate limiting
## - Team assignment for friend/foe detection
##
## SIGNALS EMITTED:
## - OnTakeDamage(health): When unit takes damage - health_bar.gd listens
## - OnDie(unit): When unit dies - main.gd listens for win condition
##
## USED BY: unit_base.tscn, unit_player.tscn, unit_ai.tscn

extends Area2D
class_name Unit

# === SIGNALS ===
signal OnTakeDamage(health : int)  # Emitted when taking damage
signal OnDie(unit : Unit)          # Emitted on death

# === MOVEMENT ===
@export var move_speed : float = 10.0  # Units per second

# === HEALTH ===
@export var current_hp : int = 20  # Current health
@export var max_hp : int = 20      # Maximum health

# === COMBAT ===
@export var attack_range : float = 20.0   # Distance to attack from
@export var attack_rate : float = 0.5     # Seconds between attacks
var last_attack_time : float              # For cooldown tracking
@export var attack_damage : int = 5       # Damage per hit

# === TEAM ===
enum Team { PLAYER, AI }   # Available teams
@export var team : Team    # Which team this unit is on

# === TARGETING ===
var attack_target : Unit   # Current attack target (null = none)

# === NAVIGATION ===
@onready var agent : NavigationAgent2D = $NavigationAgent2D


# Called when unit spawns - sets initial nav target to prevent movement
func _ready():
	agent.target_position = global_position


# Called every frame - handles movement and combat
func _process(delta):
	if not agent.is_navigation_finished():
		_move(delta)
	_target_check()


# Moves unit toward navigation target using pathfinding
func _move(delta):
	var move_pos = agent.get_next_path_position()
	var move_dir = global_position.direction_to(move_pos)
	var movement = move_dir * move_speed * delta
	translate(movement)


# Checks if we should attack or chase our target
func _target_check():
	if attack_target == null:
		return

	var dist = global_position.distance_to(attack_target.global_position)

	if dist <= attack_range:
		# In range: stop and attack
		agent.target_position = global_position
		_try_attack_target()
	else:
		# Out of range: chase target
		agent.target_position = attack_target.global_position


# Attempts attack if cooldown has passed
func _try_attack_target():
	var time = Time.get_unix_time_from_system()

	if time - last_attack_time < attack_rate:
		return  # Still on cooldown

	last_attack_time = time
	attack_target.take_damage(attack_damage)


# PUBLIC: Command unit to move (clears attack target)
func set_move_to_target(target: Vector2):
	agent.target_position = target
	attack_target = null


# PUBLIC: Command unit to attack (ignores if same team)
func set_attack_target(target: Unit):
	if target.team == team:
		return  # No friendly fire
	attack_target = target


# PUBLIC: Apply damage - emits signal, triggers death if HP <= 0
func take_damage(amount: int):
	current_hp -= amount
	OnTakeDamage.emit(current_hp)

	if current_hp <= 0:
		_die()


# Handles death - emits signal and removes from scene
func _die():
	OnDie.emit(self)
	queue_free()