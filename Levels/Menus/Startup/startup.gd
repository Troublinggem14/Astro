extends Control




func _on_fade_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Levels/Menus/StartMenu/start_menu.tscn")
