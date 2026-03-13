extends Control

@export var fish_speed: float = 200

@onready var fishoutline: Area2D = $FishOutlineArea2D
@onready var get_random_direction_timer: Timer = $get_random_direction
@onready var fishing_progress_bar: TextureProgressBar = $FishingProgressBar

var direction: Vector2 = Vector2.ZERO

var is_catching: bool


func _ready() -> void:
	randomize()
	get_random_direction_timer.start()
	set_random_direction()


func _process(delta: float) -> void:
	fishoutline.position += direction * fish_speed * delta
	
	if is_catching:
		fishing_progress_bar.value += 1
	else:
		fishing_progress_bar.value -= 1


func set_random_direction():
	direction = Vector2(
		randf_range(-1, 1),
		randf_range(-1, 1)
	).normalized()


func _on_get_random_direction_timeout() -> void:
	set_random_direction()


func _on_border_area_exited(area: Area2D) -> void:
	if area == fishoutline:
		# bounce the fish by reversing direction
		direction = -direction


func _on_fish_outline_area_2d_mouse_exited() -> void:
	is_catching = false


func _on_fish_outline_area_2d_mouse_entered() -> void:
	is_catching = true
