extends NodeState

@export var player: AstroClassName #Used for getting the players direction
@export var animated_sprite_2D: AnimatedSprite2D #Used for playing the correct anims
@export var hit_component_collision_shape: CollisionShape2D #used for enabling and disabling the collishion for hitting things
@export var oxygen_bar: TextureProgressBar #used for depleting the oxygen bar on enter()
@export var hitcomponent: HitComponent #used for making the hit component use the correct tool based on the state playing
@export var oxygen_drain: int

func _ready() -> void:
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2(0,0)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	#if the animations finished, transition to idle
	if !animated_sprite_2D.is_playing(): 
		transition.emit("Idle")

#elif the oxygen bar has run out, transition to die
	elif oxygen_bar.value == 0:
		transition.emit("Die")


#This function plays whenever the state starts, basically its ready function but it can happen more than once
func _on_enter() -> void:
	oxygen_bar.value -= oxygen_drain #Depletes the oxygen by the amount you want it to drain
	hitcomponent.current_tool = data_types.Tools.TillGround
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
