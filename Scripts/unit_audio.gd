## unit_audio.gd - Sound effects for units
##
## WHAT THIS DOES:
## - Plays sound effects when unit events occur
## - Currently: plays damage sound when unit takes damage
##
## HOW IT WORKS:
## - Connects to parent unit's OnTakeDamage signal
## - Plays the assigned audio stream when signal fires
##
## FUTURE: Add attack sounds, death sounds, selection sounds
##
## USED BY: unit_base.tscn (AudioStreamPlayer2D node)

extends AudioStreamPlayer2D

@export var take_damage_sfx : AudioStream  # Assign in inspector (Audio/take_damage.wav)


# Connect to parent unit's damage signal
func _ready():
	var unit = get_parent()
	unit.OnTakeDamage.connect(_play_take_damage_sfx)


# Play damage sound when unit takes damage
func _play_take_damage_sfx(health : int):
	_play_sound(take_damage_sfx)


# Helper: Play any audio stream
func _play_sound(audio : AudioStream):
	stream = audio
	play()