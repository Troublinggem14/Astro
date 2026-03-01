extends Node

@export var day_length_seconds: float = 600.0 # 10 minutes per full day
var time_of_day: float = 0.5 # 0 → 1
#| 0.0   | Midnight       |
#| 0.25  | 6 AM           |
#| 0.5   | Noon           |
#| 0.75  | 6 PM           |
#| 1.0   | Midnight again |


var time_speed: float

func _ready():
	time_speed = 1.0 / day_length_seconds

func _process(delta):
	time_of_day += delta * time_speed
	if time_of_day >= 1.0:
		time_of_day = 0.0

func get_formatted_time() -> String:
	var total_minutes = int(time_of_day * 1440) # 1440 minutes in a day
	
	var hours = total_minutes / 60
	var minutes = total_minutes % 60
	
	return "%02d:%02d" % [hours, minutes]
