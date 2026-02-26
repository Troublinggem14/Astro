extends Control
const START_MENU = preload("uid://cu3lk2hnyq8it")





func _on_fade_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_packed(START_MENU)
