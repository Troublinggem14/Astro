extends RayCast2D

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if is_colliding() and get_collider().is_in_group("Water"):
		FishingManager.can_fish = true
	else:
		FishingManager.can_fish = false
