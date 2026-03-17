extends Control

@export var indicator_speed: float = 300.0

@onready var bar = $Bar
@onready var indicator = $Bar/Indicator
@onready var target = $Bar/TargetZone

var direction := 1
var finished := false


func _process(delta):

	if finished:
		return

	move_indicator(delta)

	if Input.is_action_just_pressed("action"):
		check_success()


func move_indicator(delta):

	indicator.position.x += indicator_speed * direction * delta

	if indicator.position.x + indicator.size.x >= bar.size.x:
		direction = -1

	if indicator.position.x <= 0:
		direction = 1


func check_success():

	finished = true
	FishingManager.can_stop_fishing = true

	if indicator.get_rect().intersects(target.get_rect()):
		AudioManager.play_reel_in_fish()
	else:
		AudioManager.play_line_break()

	queue_free()
