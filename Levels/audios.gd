extends Node

func play_mining_audio():
	$RockHit.play()

func play_chopping_audio():
	$LogHit.play()

func play_casting_line():
	$Casting_Line.play()

func play_fish_bite():
	$Fish_Bite.play()
func _on_fish_bite_finished() -> void:
	play_fish_bite()
func pause_fish_bite():
	$Fish_Bite.stream_paused = true
func stop_fish_audio():
	$Fish_Bite.stop()

func play_reel_in_fish():
	$Reel_in_fish.play()

func play_line_break():
	$Line_Break.play()
