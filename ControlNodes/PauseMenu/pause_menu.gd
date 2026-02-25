extends Node2D

func _ready() -> void:
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		visible = !visible
		$ColorRect.hide()


func _on_button_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	$ColorRect.show()
	$Credits2/AnimationPlayer.play("Credits Flow")
