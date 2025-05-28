extends Control

@onready var game_manager = $"../GameManager"


func _on_main_menu_button_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Scenes/00_MainMenu.tscn")
	
func _on_resume_button_pressed():
	game_manager.pause_unpause()
