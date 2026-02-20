extends Control

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_options_button_pressed() -> void:
	$TextLabels/AnimationPlayer.stop() #stops the animatino, as it turns the visibility back on every second
	$TextLabels/Screen_Press_Play.visible = false # turns off the previous text on the screen
	$Options.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()
