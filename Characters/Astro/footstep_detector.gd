extends Area2D

func _on_area_entered(area):

	if area.has_method("get_surface_type"):
		var surface = area.get_surface_type()
		footstep_manager.set_surface(surface)
