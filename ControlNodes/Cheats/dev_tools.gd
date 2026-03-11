extends CanvasLayer

#--Oxygen bar--#
@export var oxygen_bar: TextureProgressBar
var oxygen_toggle: bool

#--Speed_Multiplier--#
@export var walk_state: Node

#--Player_collision--#
@export var player_collision: CollisionShape2D

func _on_oxygen_bar_toggle_toggled(toggled_on: bool) -> void:
	oxygen_toggle = toggled_on
	
	

func _process(delta: float) -> void:
	if oxygen_toggle:
		oxygen_bar.value = 100


func _on_h_scroll_bar_value_changed(value: float) -> void:
	walk_state.speed = value


func _on_collision_toggle_toggled(toggled_on: bool) -> void:
	player_collision.disabled = toggled_on
