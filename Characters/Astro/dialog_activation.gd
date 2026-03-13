extends Node2D
#Used to find out when the Raycast detects the NPCS
@onready var dialog_ray_cast: RayCast2D = $"../Dialog_RayCast" 

#Used to get the NPCS Dialog Collider (Area2D)
var npc 


# --- When the raycast changes its draw order, whatever the raycast is detecting becomes
#the npc variable (the collision can ONLY see NPCS) --
func _on_dialog_ray_cast_draw() -> void:
	npc = dialog_ray_cast.get_collider()
	if npc == null:
		return

#--- if I press Action[E] and I am looking at an NPC, it gets the NPCS Parent.
# The Parent is used to access the export variable attatched to it (Dialog_Player)
# If the Dialog_player is not null (If they have nothing to say to you) then it starts
# the dialog_player ---#
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and EventBus.can_start_dialog:
		if npc == null:
			return
		var npc_parent = npc.get_parent()
		if npc_parent.dialog_player == null:
			return
		npc_parent.dialog_player.start()
