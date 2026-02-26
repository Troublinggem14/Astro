extends Sprite2D
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent


func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damaged_reached.connect(on_max_damage_reached)
	
func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	EventBus.tree_hit.emit()
	$GPUParticles2D.emitting = true
	$AnimationPlayer.play("Shake")

func on_max_damage_reached() -> void:
	EventBus.spawn_log.emit(position)
	queue_free()
