extends NodeState

@export var player: AstroClassName
@export var animated_sprite_2D: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D
@export var oxygen_bar: TextureProgressBar
@export var hitcomponent: HitComponent
@export var oxygen_drain: int


func _on_process(_delta : float) -> void:
	if Input.is_action_just_pressed("action") \
	and animated_sprite_2D.animation.begins_with("Fishing_Idle") \
	and FishingManager.can_stop_fishing:
		stop_fishing()


func _on_next_transitions() -> void:
	if oxygen_bar.value == 0:
		transition.emit("Die")
	elif !animated_sprite_2D.is_playing():
		transition.emit("Idle")


func _on_enter() -> void:
	play_bobber_audio()
	
	if FishingManager.can_fish:
		oxygen_bar.value -= oxygen_drain
		hitcomponent.current_tool = data_types.Tools.Fishing

		var dir = player.player_direction

		if dir == Vector2.UP:
			await play_cast("Fishing_Toss_North", "North")
		elif dir == Vector2.DOWN:
			await play_cast("Fishing_Toss_South", "South")
		elif dir == Vector2.RIGHT:
			await play_cast("Fishing_Toss_East", "East")
		elif dir == Vector2.LEFT:
			await play_cast("Fishing_Toss_West", "West")
		else:
			await play_cast("Fishing_Toss_North", "North")


func _on_exit() -> void:
	FishingManager.stop_fishing()
	animated_sprite_2D.stop()


func play_cast(anim_name: String, dir: String) -> void:
	animated_sprite_2D.play(anim_name)
	await get_tree().create_timer(1.3).timeout
	idle_fishing(dir)


func idle_fishing(direction: String):
	match direction:
		"North":
			animated_sprite_2D.play("Fishing_Idle_North")
		"South":
			animated_sprite_2D.play("Fishing_Idle_South")
		"East":
			animated_sprite_2D.play("Fishing_Idle_East")
		"West":
			animated_sprite_2D.play("Fishing_Idle_West")

	FishingManager.start_fishing()


func stop_fishing():
	FishingManager.stop_fishing()
	AudioManager.play_de_casting_line()

	var dir = player.player_direction

	if dir == Vector2.UP:
		await play_stop("Fishing_Toss_North")
	elif dir == Vector2.DOWN:
		await play_stop("Fishing_Toss_South")
	elif dir == Vector2.RIGHT:
		await play_stop("Fishing_Toss_East")
	elif dir == Vector2.LEFT:
		await play_stop("Fishing_Toss_West")
	else:
		await play_stop("Fishing_Toss_North")


func play_stop(anim_name: String):
	animated_sprite_2D.play_backwards(anim_name)
	await get_tree().create_timer(1.3).timeout
	transition.emit("Idle")


func play_bobber_audio():
	await get_tree().create_timer(0.5).timeout
	AudioManager.play_casting_line()
