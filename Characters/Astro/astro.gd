extends CharacterBody2D
class_name AstroClassName
@export var current_tool: data_types.Tools = data_types.Tools.None
@onready var inventory: Inventory = $Inventory

var player_direction: Vector2
