extends NodeState

@export var player: AstroClassName
@export var animated_sprite_2D: AnimatedSprite2D

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
#---Setting the Idle animations based on the direction---#
	if player.player_direction == Vector2.UP:
		animated_sprite_2D.play("Idle_North")
	elif player.player_direction == Vector2.DOWN:
		animated_sprite_2D.play("Idle_South")
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite_2D.play("Idle_East")
	elif player.player_direction == Vector2.LEFT:
		animated_sprite_2D.play("Idle_West")
	else:
		animated_sprite_2D.play("Idle_North")

func _on_next_transitions() -> void:
	if EventBus.can_idle_transition:
		GameInputEvent.movement_input()
		
		if GameInputEvent.movement_input():
			transition.emit("Walk")
			
		if player.current_tool == data_types.Tools.AxeWood and GameInputEvent.use_tool():
			transition.emit("Chopping")
		if player.current_tool == data_types.Tools.MineStone and GameInputEvent.use_tool():
			transition.emit("Mining")
		if player.current_tool == data_types.Tools.TillGround and GameInputEvent.use_tool():
			transition.emit("Tilling")
		if player.current_tool == data_types.Tools.WaterCrops and GameInputEvent.use_tool():
			transition.emit("Watering")
		if player.current_tool == data_types.Tools.Fishing and GameInputEvent.use_tool():
			transition.emit("Fishing")


func _on_enter() -> void:
	EventBus.can_idle_transition = true
	EventBus.can_start_dialog = true


func _on_exit() -> void:
	animated_sprite_2D.stop()
