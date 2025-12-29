## menu.gd - Main menu button handlers
##
## WHAT THIS DOES:
## - Play button: Starts the game (loads main.tscn)
## - Quit button: Exits the application
##
## BUTTON SIGNALS (connected in menu.tscn):
## - PlayButton.pressed -> _on_play_button_pressed
## - QuitButton.pressed -> _on_quit_button_pressed
##
## USED BY: menu.tscn (root Control node)

extends Control


# Quit button: Exit the game
func _on_quit_button_pressed() -> void:
	get_tree().quit()


# Play button: Load the main game scene
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
