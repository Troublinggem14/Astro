extends Control
const MAIN = preload("uid://cy08xdbgpwo0b")




func _on_audio_stream_player_2d_finished() -> void:
	get_tree().change_scene_to_packed(MAIN)
