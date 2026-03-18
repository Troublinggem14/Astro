extends Control

@export var indicator_speed: float = 300.0

@onready var bar = $Bar
@onready var indicator = $Bar/Indicator
@onready var target = $Bar/TargetZone

var direction = 1
var finished = false
var can_press = false


func _ready():
	# Small delay so previous input doesn't carry over
	await get_tree().create_timer(0.2).timeout
	can_press = true


func _process(delta):
	if finished:
		return

	move_indicator(delta)

	if can_press and Input.is_action_just_pressed("action"):
		check_success()


func move_indicator(delta):
	indicator.position.x += indicator_speed * direction * delta

	if indicator.position.x + indicator.size.x >= bar.size.x:
		direction = -1

	if indicator.position.x <= 0:
		direction = 1


func check_success():
	finished = true

	var success = indicator.get_global_rect().intersects(target.get_global_rect())

	if success:
		AudioManager.play_reel_in_fish()
	else:
		AudioManager.play_line_break()

	await get_tree().create_timer(0.5).timeout
	
	FishingManager.minigame_result(success)  # passes result
	queue_free()
