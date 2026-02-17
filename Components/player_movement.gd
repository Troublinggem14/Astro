extends Node2D
class_name MovementComponent


@export var player: Node2D
@export var move_speed: int


func _unhandled_input(_event: InputEvent) -> void:
	movement()

func movement():
	var direction = Input.get_vector("left","right","up","down")
	player.velocity = direction * move_speed
	
	
