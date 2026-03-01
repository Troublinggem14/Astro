extends Node2D

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	visible = PausedState.show_pause_menu


func _on_button_pressed() -> void:
	get_tree().quit()
