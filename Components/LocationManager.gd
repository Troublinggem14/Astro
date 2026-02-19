extends Node2D
var is_inside: bool
@export var locationToBeSent: PackedScene
@export var locationToSpawn: Marker2D

func _ready() -> void:
	await get_tree().process_frame
	if EventBus.Astro:
		EventBus.Astro.global_position = locationToSpawn.global_position



func _on_area_2d_body_entered(body) -> void:
	if body == EventBus.Astro:
		is_inside = true
		$"interact label".show()

func _on_area_2d_body_exited(body) -> void:
	if body == EventBus.Astro:
		is_inside = false
		$"interact label".hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_inside == true:
		EventBus.spawn_position = locationToSpawn.global_position
		get_tree().change_scene_to_packed(locationToBeSent)
