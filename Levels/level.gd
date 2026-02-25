extends Node
const LOG = preload("uid://c5p108fex7447")

func _ready() -> void:
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
		
	EventBus.spawn_log.connect(spawn_log)
func _on_level_spawn(desination_tag: String):
	var door_path = "Doors/Door_" + desination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn_point.global_position, door.spawn_direction)


func spawn_rock():
	print("Spawn Rock")
	
func spawn_log(position: Vector2):
	var new_log = LOG.instantiate()
	add_child.call_deferred(new_log)
	new_log.global_position = position
