extends Node
const LOG = preload("uid://c5p108fex7447")
const ROCK = preload("uid://c77vidh2jcj03")

func _ready() -> void:
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
		
	$FadingComponent.FadeIn()
	EventBus.spawn_log.connect(spawn_log)
	EventBus.spawn_rock.connect(spawn_rock)
func _on_level_spawn(desination_tag: String):
	var door_path = "Doors/Door_" + desination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn_point.global_position, door.spawn_direction)


func spawn_rock(position: Vector2):
	var new_rock = ROCK.instantiate()
	$Rocks.add_child.call_deferred(new_rock)
	new_rock.global_position = position
	
func spawn_log(position: Vector2):
	var new_log = LOG.instantiate()
	$Logs.add_child.call_deferred(new_log)
	new_log.global_position = position
