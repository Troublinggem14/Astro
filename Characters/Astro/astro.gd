extends CharacterBody2D

func _ready():
	EventBus.Astro = self
	if EventBus.spawn_position:
		global_position = EventBus.spawn_position


func _physics_process(delta):
	move_and_slide()
