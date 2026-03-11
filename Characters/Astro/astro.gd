extends CharacterBody2D
class_name AstroClassName #Used for export variables (States)
@export var current_tool: data_types.Tools = data_types.Tools.None #Used for my idle_state.gd and hotbar_ui.gd


var player_direction: Vector2 #used for my States in the StateMachine
