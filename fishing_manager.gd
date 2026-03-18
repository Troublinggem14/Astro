extends Node

var fishing_minigame = preload("uid://bo0r2j7vkqcdl")

var can_stop_fishing = false
var can_fish: bool
var is_fishing = false
var can_catch = false

var fishing_loop_running = false


func start_fishing():
	if fishing_loop_running:
		return
	
	is_fishing = true
	can_stop_fishing = true
	fishing_loop_running = true
	
	fishing_loop()


func stop_fishing():
	is_fishing = false
	can_stop_fishing = false
	can_catch = false
	fishing_loop_running = false
	AudioManager.stop_fish_audio()


func fishing_loop():
	while is_fishing:
		var bite_time = randf_range(1, 5)
		await get_tree().create_timer(bite_time).timeout
		
		if !is_fishing:
			break
		
		# Fish bites
		AudioManager.play_fish_bite()
		can_catch = true
		can_stop_fishing = false
		
		# Time window to react
		await get_tree().create_timer(3).timeout
		
		if can_catch:
			# Missed fish
			AudioManager.pause_fish_bite()
			can_catch = false
			can_stop_fishing = true


func _input(event):
	if event.is_action_pressed("action") and can_catch:
		caught_fish()


func caught_fish():
	can_catch = false
	is_fishing = false
	can_stop_fishing = false
	fishing_loop_running = false
	
	AudioManager.stop_fish_audio()
	start_minigame()


func start_minigame():
	var minigame = fishing_minigame.instantiate()
	var ui = get_tree().get_first_node_in_group("ui")
	ui.add_child(minigame)

func minigame_result(success: bool):
	if success:
		# WIN → stop fishing completely
		stop_fishing()
		
		# Tell player state to pull rod out
		var player = get_tree().get_first_node_in_group("Astro")
		if player:
			player.call("on_fish_caught")  # we'll add this
	else:
		# LOSE → keep fishing
		start_fishing()
# Called by minigame when done
func resume_fishing():
	start_fishing()
