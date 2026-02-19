extends Area2D

class_name Door

@export var desitnation_level_name: String
@export var desination_door_name: String
@export var spawn_direction: String

@onready var spawn_point: Marker2D = $SpawnPoint


func _on_body_entered(body: AstroClassName) -> void:
	NavigationManager.go_to_level(desitnation_level_name, desination_door_name)


func _on_body_exited(body: AstroClassName) -> void:
	pass # Replace with function body.
