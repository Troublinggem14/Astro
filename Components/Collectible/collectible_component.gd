class_name CollectableComponent
extends Area2D

@export var collectable_name: String
var player = AstroClassName


func _on_body_entered(body) -> void:
	if body is AstroClassName:
		get_parent().queue_free() #getting parent as you want to get rid of the actual collectible, not just the component
