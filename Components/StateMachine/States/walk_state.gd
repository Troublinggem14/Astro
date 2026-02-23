extends NodeState
@export var player: AstroClassName
@export var animated_sprite_2D: AnimatedSprite2D

@export var speed: int = 200


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvent.movement_input()
	
	if direction == Vector2.UP:
		animated_sprite_2D.play("Walk_North")
	elif direction == Vector2.DOWN:
		animated_sprite_2D.play("Walk_South")
	elif direction == Vector2.RIGHT:
		animated_sprite_2D.play("Walk_East")
	elif direction == Vector2.LEFT:
		animated_sprite_2D.play("Walk_West")
		
	if direction != Vector2.ZERO:
		player.player_direction = direction
		
	player.velocity = direction * speed
	player.move_and_slide()


func _on_next_transitions() -> void:
	if !GameInputEvent.is_movement_input():
		transition.emit("Idle")
	if player.current_tool == data_types.Tools.AxeWood and GameInputEvent.use_tool():
		transition.emit("Chopping")
	if player.current_tool == data_types.Tools.MineStone and GameInputEvent.use_tool():
		transition.emit("Mining")
	if player.current_tool == data_types.Tools.TillGround and GameInputEvent.use_tool():
		transition.emit("Tilling")
	if player.current_tool == data_types.Tools.WaterCrops and GameInputEvent.use_tool():
		transition.emit("Watering")



func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2D.stop()
