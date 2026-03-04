class_name CollectableComponent
extends Area2D  # Detects physics bodies entering pickup range

func _on_body_entered(body) -> void:
	get_parent().queue_free()
