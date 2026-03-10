extends NodeState

@export var player: AstroClassName
@export var animated_sprite_2D: AnimatedSprite2D
@export var oxygen_bar: TextureProgressBar

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !animated_sprite_2D.is_playing():
		transition.emit("Idle")
	elif oxygen_bar.value == 0:
		transition.emit("Die")


func _on_enter() -> void:
	oxygen_bar.value -= 1
	if player.player_direction == Vector2.UP:
		animated_sprite_2D.play("Till_North")
	elif player.player_direction == Vector2.DOWN:
		animated_sprite_2D.play("Till_South")
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite_2D.play("Till_East")
	elif player.player_direction == Vector2.LEFT:
		animated_sprite_2D.play("Till_West")
	else:
		animated_sprite_2D.play("Till_North")


func _on_exit() -> void:
	animated_sprite_2D.stop()
