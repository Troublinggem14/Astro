extends Node2D

@onready var dialog_ray_cast: RayCast2D = $"../Dialog_RayCast"
@export var NPCDialog:NPC

var npc


func _on_dialog_ray_cast_draw() -> void:
	npc = dialog_ray_cast.get_collider()
	if npc == null:
		return

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if npc == null:
			return
		if NPCDialog.dialog_player == null:
			return
		NPCDialog.dialog_player.start()
