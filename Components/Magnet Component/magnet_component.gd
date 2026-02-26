class_name MagnetComponent
extends Area2D

var is_inside: bool


@export var player: AstroClassName
@export var magnet_speed : int

var pulled_items = []

func _on_area_entered(area: Area2D) -> void:
	var collectible = area.get_parent()
	pulled_items.append(collectible)

func _physics_process(delta):
	for collectible in pulled_items:
		if is_instance_valid(collectible):
			var direction = (player.global_position - collectible.global_position).normalized()
			collectible.global_position += direction * magnet_speed * delta
