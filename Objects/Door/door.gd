extends Area2D

class_name Door

var is_inside: bool

@export var desitnation_level_name: String #name of the scene youre going to
@export var desination_door_name: String #name of the door youre going to 
@export var spawn_direction: String #direction you want your player to face after teleporting

@onready var spawn_point: Marker2D = $SpawnPoint


func _process(delta: float) -> void:
	if is_inside == true and Input.is_action_just_pressed("interact"):
		NavigationManager.go_to_level(desitnation_level_name, desination_door_name)

func _on_body_entered(body: AstroClassName) -> void:
	is_inside = true
	


func _on_body_exited(body: AstroClassName) -> void:
	is_inside = false
