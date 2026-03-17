extends NodeState

@export var player: AstroClassName
@export var animated_sprite_2D: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D
@export var oxygen_bar: TextureProgressBar
@export var hitcomponent: HitComponent
@export var oxygen_drain: int


func _on_process(_delta : float) -> void:
	if Input.is_action_just_pressed("action") and animated_sprite_2D.animation.begins_with("Fishing_Idle"):
		stop_fishing()


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if oxygen_bar.value == 0:
		transition.emit("Die")

	elif !animated_sprite_2D.is_playing():
		transition.emit("Idle")


func _on_enter() -> void:
	play_bobber_audio()
	
	if FishingManager.can_fish == true:
		oxygen_bar.value -= oxygen_drain
		hitcomponent.current_tool = data_types.Tools.Fishing

		if player.player_direction == Vector2.UP:
			animated_sprite_2D.play("Fishing_Toss_North")
			await get_tree().create_timer(1.3).timeout
			idle_fishing("North")

		elif player.player_direction == Vector2.DOWN:
			animated_sprite_2D.play("Fishing_Toss_South")
			await get_tree().create_timer(1.3).timeout
			idle_fishing("South")

		elif player.player_direction == Vector2.RIGHT:
			animated_sprite_2D.play("Fishing_Toss_East")
			await get_tree().create_timer(1.3).timeout
			idle_fishing("East")

		elif player.player_direction == Vector2.LEFT:
			animated_sprite_2D.play("Fishing_Toss_West")
			await get_tree().create_timer(1.3).timeout
			idle_fishing("West")

		else:
			animated_sprite_2D.play("Fishing_Toss_North")
			await get_tree().create_timer(1.3).timeout
			idle_fishing("North")
			


func _on_exit() -> void:
	FishingManager.is_fishing = false
	animated_sprite_2D.stop()


func idle_fishing(direction: String):
	match direction:
		"North":
			animated_sprite_2D.play("Fishing_Idle_North")
			FishingManager.is_fishing = true
			FishingManager.start_fishing()
		"South":
			animated_sprite_2D.play("Fishing_Idle_South")
			FishingManager.is_fishing = true
			FishingManager.start_fishing()
		"East":
			animated_sprite_2D.play("Fishing_Idle_East")
			FishingManager.is_fishing = true
			FishingManager.start_fishing()
		"West":
			animated_sprite_2D.play("Fishing_Idle_West")
			FishingManager.is_fishing = true
			FishingManager.start_fishing()
			
func stop_fishing():
	if FishingManager.can_stop_fishing == true:
	
		if player.player_direction == Vector2.UP:
			animated_sprite_2D.play_backwards("Fishing_Toss_North")
			await get_tree().create_timer(1.3).timeout
			_on_exit()

		elif player.player_direction == Vector2.DOWN:
			animated_sprite_2D.play_backwards("Fishing_Toss_South")
			await get_tree().create_timer(1.3).timeout
			_on_exit()

		elif player.player_direction == Vector2.RIGHT:
			animated_sprite_2D.play_backwards("Fishing_Toss_East")
			await get_tree().create_timer(1.3).timeout
			_on_exit()

		elif player.player_direction == Vector2.LEFT:
			animated_sprite_2D.play_backwards("Fishing_Toss_West")
			await get_tree().create_timer(1.3).timeout
			_on_exit()

		else:
			animated_sprite_2D.play_backwards("Fishing_Toss_North")
			await get_tree().create_timer(1.3).timeout
			_on_exit()

func play_bobber_audio():
	await get_tree().create_timer(.5).timeout
	AudioManager.play_casting_line()
