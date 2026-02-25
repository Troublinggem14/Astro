extends Node


func _ready() -> void:
	EventBus.rock_hit.connect(play_mining_audio)
	EventBus.tree_hit.connect(play_chopping_audio)
func play_mining_audio():
	$RockHit.play()
func play_chopping_audio():
	$LogHit.play()
