extends HSlider
@export var camera: Camera2D



func _on_value_changed(value: float) -> void:
	camera.zoom = Vector2(value, value)
