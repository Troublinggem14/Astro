extends Area2D

@export var target_scene: String
var player_inside := false

func _ready():
	$"FadingComponent/Fade Background".visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	player_inside = true

func _on_body_exited(body):
	player_inside = false

func _unhandled_input(event: InputEvent) -> void:
	if player_inside and event.is_action_pressed("interact"):
		$"FadingComponent/Fade Background".visible = true
		$FadingComponent.FadeOut()

func change_scene():
	get_tree().change_scene_to_file(target_scene)


func _on_fading_animation_finished(anim_name: StringName) -> void:
	change_scene()
