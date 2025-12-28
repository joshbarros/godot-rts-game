extends Area2D
class_name Unit

signal OnTakeDamage(health : int)
signal OnDie(unit : Unit)

@export var move_speed : float = 10.0

@export var current_hp : int = 20
@export var max_hp : int = 20

@export var attack_range : float = 20.0
@export var attack_rate : float = 0.5
var last_attack_time : float
@export var attack_damage : int = 5

enum Team { PLAYER, AI }
@export var team : Team

var attack_target : Unit

@onready var agent : NavigationAgent2D = $NavigationAgent2D

func _process(delta):
    pass

func _move(delta):
    pass

func _target_check():
    pass

func _try_attack_target():
    pass

func set_move_to_target(target: Vector2):
    pass

func set_attack_target(target: Unit):
    pass

func take_damage(amount: int):
    pass

func _die():
    pass