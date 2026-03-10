extends Resource
class_name ItemData

@export var id: String
@export var display_name: String
@export var description: String
@export var icon: Texture2D
@export var max_stack: int = 20
@export var tool_type: data_types.Tools = data_types.Tools.None
