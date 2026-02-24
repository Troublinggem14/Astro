class_name HitComponent
extends Area2D
@export var current_tool: data_types.Tools = data_types.Tools.None
@export var hit_damage: int = 1

signal on_hit
