## end_screen.gd - Victory/defeat screen at end of game
##
## WHAT THIS DOES:
## - Displays winning team name
## - Provides button to return to main menu
##
## HOW IT WORKS:
## - Hidden by default (set visible = false in scene)
## - main.gd calls set_screen() when game ends
## - Menu button returns to menu.tscn
##
## USED BY: main.tscn (CanvasLayer/EndScreen node)

extends Panel

@onready var header_text : Label = $HeaderText  # "PLAYER team has won!" text


# PUBLIC: Show the end screen with winning team name
# Called by main.gd when win condition is met
func set_screen(winning_team : String):
	visible = true
	header_text.text = winning_team + " team has won!"


# Menu button: Return to main menu
func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
