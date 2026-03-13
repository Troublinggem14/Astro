extends RayCast2D

var water

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if is_colliding() and get_collider().is_in_group("Water"):
		EventBus.can_fish = true
	else:
		EventBus.can_fish = false
