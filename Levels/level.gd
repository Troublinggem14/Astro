extends Node
const LOG = preload("res://Objects/Collectibles/log.tscn")
const ROCK = preload("res://Objects/Collectibles/stone.tscn")

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
	
