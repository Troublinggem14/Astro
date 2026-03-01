extends CanvasLayer
@onready var fading: AnimationPlayer = $Fading
func _ready() -> void:
	visible = true#so its easier to see my scenes in the editor without the UI covering it up

func FadeOut():
	fading.play("FadeOut")
func FadeIn():
	fading.play("FadeIn")


func _on_fading_animation_finished(anim_name: StringName) -> void:
	$"Fade Background".modulate = "ffffff00"
