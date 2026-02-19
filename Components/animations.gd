extends Node2D
@export var player: Node2D
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@export var tool_node: Node2D

var last_direction = Vector2.DOWN
var velocity: Vector2
var Direction : String = "South"


func _ready() -> void:
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
	
func _on_spawn(position: Vector2, direction: String):
	player.global_position = position
	Direction = direction   # <-- THIS is what you're missing
	animation_player.play("Idle_" + Direction)




enum Tool {
	NONE,
	AXE,
	PICKAXE
}

func _physics_process(delta: float) -> void:
	velocity = player.velocity
	direction()
	IdleWalkanimations()


func IdleWalkanimations() -> void:
	if velocity != Vector2.ZERO:
		if animation_player.current_animation != "Walk_" + Direction:
			animation_player.play("Walk_" + Direction)
	else:
		if animation_player.current_animation != "Idle_" + Direction:
			animation_player.play("Idle_" + Direction)


func direction():
	if AnimationsGlobal.key_pressed.y > 0:
		Direction = "South"
	elif AnimationsGlobal.key_pressed.y < 0:
		Direction = "North"
	elif AnimationsGlobal.key_pressed.x < 0:
		Direction = "West"
	elif AnimationsGlobal.key_pressed.x > 0:
		Direction = "East"
	else:
		return
