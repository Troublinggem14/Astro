extends  CharacterBody2D
class_name NPC

#--- Used to access the current dialog playing, so we can change its position, also used
#For the dialog_activation script (Child of Astro) ---#
@export var dialog_player: DialogPlayer
@export var Astro_State_Machine: NodeStateMachine




func _on_dialog_player_dialog_started() -> void:
	#--- Gets the position set in the Variables menu under Dialogs ⬆️---#
	var box_position = SproutyDialogs.Variables.get_variable("Position")
	dialog_player._current_dialog_box.position = box_position
	EventBus.can_idle_transition = false


func _on_dialog_player_dialog_ended() -> void:
	#--- if the dialog_player is null (Have nothing to say anymore) sets the eventbus 
	#can idle_transition to true, allowing you to move again because you cant mov unless
	# you can transition from idle to walk. ---#
	EventBus.can_idle_transition = true
