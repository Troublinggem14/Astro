extends Node
const LOG = preload("uid://c5p108fex7447")
const ROCK = preload("uid://c77vidh2jcj03")

func _ready() -> void:
	
	$FadingComponent.FadeIn()
	EventBus.spawn_log.connect(spawn_log)
	EventBus.spawn_rock.connect(spawn_rock)


func spawn_rock(position: Vector2):
	var new_rock = ROCK.instantiate()
	$Rocks.add_child.call_deferred(new_rock)
	new_rock.global_position = position
	
func spawn_log(position: Vector2):
	var new_log = LOG.instantiate()
	$Logs.add_child.call_deferred(new_log)
	new_log.global_position = position
