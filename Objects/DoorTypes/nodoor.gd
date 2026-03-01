extends Area2D

@export var target_scene: String

func _ready():
	$"FadingComponent/Fade Background".visible = false
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	$"FadingComponent/Fade Background".visible = true
	$FadingComponent.FadeOut()

func change_scene():
	get_tree().change_scene_to_file(target_scene)


func _on_fading_animation_finished(anim_name: StringName) -> void:
	change_scene()
