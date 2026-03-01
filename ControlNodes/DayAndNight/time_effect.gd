extends CanvasModulate

func _process(delta):
	var t = TimeManager.time_of_day
	
	# Convert 0-1 time to light intensity
	var light_value = sin(t * PI * 2.0 - PI/2.0) * 0.5 + 0.5
	
	# Clamp so night isn't pitch black
	light_value = clamp(light_value, 0.15, 1.0)

	var night_color = Color(0.1, 0.2, 0.35) # bluish green night
	var day_color = Color(1, 1, 1)

	color = night_color.lerp(day_color, light_value)
	
