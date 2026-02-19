extends Node2D
@export var player: Node2D
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@export var tool_node: Node2D

var last_direction = Vector2.DOWN
var velocity: Vector2
var Direction : String = "South"

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
		animation_player.play("Walk_" + Direction)
	elif velocity == Vector2.ZERO:
		animation_player.play("Idle_" + Direction)
	else:
		return

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
