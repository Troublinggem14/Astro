extends Node
var fishing_minigame = preload("uid://bo0r2j7vkqcdl")

#-- for minigame --#
var can_stop_fishing = false

var can_fish: bool
var is_fishing = false
var can_catch = false


func start_fishing():
	is_fishing = true
	can_stop_fishing = true
	wait_for_bite()


func wait_for_bite():
	var bite_time = randf_range(1,5)
	await get_tree().create_timer(bite_time).timeout
	
	if !is_fishing:
		return
	
	fish_bite()


func fish_bite():
	AudioManager.play_fish_bite()
	can_catch = true
	FishingManager.can_stop_fishing = false
	
	await get_tree().create_timer(3).timeout
	
	if can_catch:
		AudioManager.pause_fish_bite()
		can_catch = false
		wait_for_bite()


func _input(event):
	if event.is_action_pressed("jump") and can_catch:
		caught_fish()


func caught_fish():
	AudioManager.stop_fish_audio()
	can_catch = false
	is_fishing = false
	can_stop_fishing = false
	
	start_minigame()
	
func start_minigame():

	var minigame = preload("res://ControlNodes/Minigames/fishing_minigame.tscn").instantiate()
	var ui = get_tree().get_first_node_in_group("ui")
	ui.add_child(minigame)
	
	
