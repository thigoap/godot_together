extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/01_Level01.tscn")
	GameManager.in_game = true


func _on_credits_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
