extends Control

var shoot: int = 0

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_options_button_pressed() -> void:
	$TextLabels/AnimationPlayer.stop() #stops the animatino, as it turns the visibility back on every second
	$TextLabels/Screen_Press_Play.visible = false # turns off the previous text on the screen
	$Options.visible = true


func explode():
	$Planet.play("Explosion")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on__pressed() -> void:
	$"FakeButtons/VBoxContainer/HBoxContainer2/1".disabled = true
	shoot += 1
	if shoot == 3:
		explode()

func two_on__pressed() -> void:
	$"FakeButtons/VBoxContainer/HBoxContainer/2".disabled = true
	shoot += 1
	if shoot == 3:
		explode()

func three_on__pressed() -> void:
	$"FakeButtons/VBoxContainer/HBoxContainer2/3".disabled = true
	shoot += 1
	if shoot == 3:
		explode()
